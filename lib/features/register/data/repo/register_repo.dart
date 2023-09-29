import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';

class RegisterRepository {
  static Future<dynamic> register(
      {required String email,
      required String password,
      required String name,
      required String passwordConfirm}) async{
    return await Api.post(url: EndPoints.baseUrl + EndPoints.registerEndpoint, body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm
    });
  }
}
