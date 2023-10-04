import 'dart:convert';

import 'package:ketaby/core/data/models/user_model.dart';
import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';

class ProfileRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static String _token = "";
  static Map<String, dynamic> _data = {};
  static Future<Map<String, dynamic>> updateProfile(
      {required Map<String, dynamic> body}) async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.post(
        url: EndPoints.baseUrl + EndPoints.updateProfileEndPoint,
        body: body,
        token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(
          errorMessage: _data['message'] as String,
          errors: _data['errors'] as Map<String, dynamic>);
    }
    UserModel user = UserModel.fromJson(_data['data']);
    await _cacheHelper.setData(key: 'user', value: jsonEncode(user.toJson()));
    return _data['data'];
  }
}
