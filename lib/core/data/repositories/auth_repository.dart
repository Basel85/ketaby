import 'dart:convert';

import 'package:ketaby/core/data/models/user_model.dart';
import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';

class AuthRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static late UserModel _user;
  static Map<String, dynamic> _data = {};
  static Future<UserModel> loginOrRegister(
      {required Map<String, dynamic> body, required String endPoint}) async {
    _data = await Api.post(url: EndPoints.baseUrl + endPoint, body: body);
    if (_data['status'] == 442) {
      throw CustomException(
          errorMessage: _data['message'] as String,
          errors: _data['errors'] as Map<String, dynamic>);
    } else if (_data['status'] == 201 || _data['status'] == 200) {
      _user = UserModel.fromJson(_data['data']['user']);
      await _cacheHelper.setData(key: 'token', value: _data['data']['token']);
      await _cacheHelper.setData(
          key: 'user', value: jsonEncode(_user.toJson()));
    }
    return _user;
  }

  static Future<UserModel> login({required Map<String, dynamic> body}) async{
    return await loginOrRegister(body: body, endPoint: EndPoints.loginEndPoint);
  }
  static Future<UserModel> register({required Map<String, dynamic> body}) async{
    return await loginOrRegister(body: body, endPoint: EndPoints.registerEndpoint);
  }
}
