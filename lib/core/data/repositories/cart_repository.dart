import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/cart/data/models/cart_model.dart';

class CartRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static String _token = "";
  static Map<String, dynamic> _data = {};
  static Future<CartModel> showCart() async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.get(
        url: EndPoints.baseUrl + EndPoints.showCartEndPoint, token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(errorMessage: _data['message'] as String);
    }
    return CartModel.fromJson(_data['data']);
  }

  static Future<void> _performPostOperations(
      {required String endPoint, required Map<String, dynamic> body}) async {
        _token = await _cacheHelper.getData(key: 'token');
    await Api.post(url: EndPoints.baseUrl + endPoint, body: body,token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(errorMessage: _data['message'] as String);
    }
  }

  static Future<void> addToCart({required Map<String, dynamic> body}) async {
    await _performPostOperations(
        endPoint: EndPoints.addToCartEndPoint, body: body);
  }

  static Future<void> removeFromCart({required Map<String, dynamic> body}) async {
    await _performPostOperations(
        endPoint: EndPoints.removeFromCartEndPoint, body: body);
  }
  static Future<void> updateCart({required Map<String, dynamic> body}) async {
    await _performPostOperations(
        endPoint: EndPoints.updateCartEndPoint, body: body);
  }
}
