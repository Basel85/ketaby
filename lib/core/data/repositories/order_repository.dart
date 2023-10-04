import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';

class OrderRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static String _token = "";
  static Map<String, dynamic> _data = {};
  static Future<void> placeOrder({required Map<String, dynamic> body}) async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.post(
        url: EndPoints.baseUrl + EndPoints.placeOrderEndPoint,
        body: body,
        token: _token);
    if(_data['status'] != 200 && _data['status'] != 201){
      throw CustomException(errorMessage: _data['message']as String,errors: _data['errors'] as Map<String,dynamic>);
    }
    
  }
}
