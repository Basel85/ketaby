import 'package:ketaby/core/data/models/user_model.dart';
import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';

class RegisterRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static late UserModel _user;
  static Future<UserModel> register(
      {required String email,
      required String password,
      required String name,
      required String passwordConfirm}) async {
    final data = await Api.post(
        url: EndPoints.baseUrl + EndPoints.registerEndpoint,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirm
        });
    if (data['status'] == 442) {
      throw CustomException(
          errorMessage: data['message'] as String,
          errors: data['errors'] as Map<String, dynamic>);
    } else if (data['status'] == 201 || data['status'] == 200) {
      _user = UserModel.fromJson(data['data']['user']);
      await _cacheHelper.setData(key: 'token', value: data['data']['token']);
      await _cacheHelper.setData(
          key: 'user', value: _user.toJson().toString());
    }
    return _user;
  }
}
