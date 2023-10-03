import 'dart:convert';

import 'package:ketaby/core/data/models/user_model.dart';
import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';

class LoginRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static late UserModel _user;
  static Future<UserModel> login(
      {required String email, required String password}) async {
    final data =
        await Api.post(url: EndPoints.baseUrl + EndPoints.loginEndPoint, body: {
      'email': email,
      'password': password,
    });
    if (data['status'] == 442) {
      throw CustomException(
          errorMessage: data['message'] as String,
          errors: data['errors'] as Map<String, dynamic>);
    } else if (data['status'] == 201 || data['status'] == 200) {
      _user = UserModel.fromJson(data['data']['user']);
      await _cacheHelper.setData(key: 'token', value: data['data']['token']);
      await _cacheHelper.setData(
          key: 'user', value: jsonEncode(data['data']['user']));
    }
    return _user;
  }
}
