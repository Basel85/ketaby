import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/order_details/data/models/order_model.dart';
import 'package:ketaby/features/order_history/data/models/order_history_model.dart';

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
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(
          errorMessage: _data['message'] as String,
          errors: _data['errors'] as Map<String, dynamic>);
    }
  }

  static Future<List<OrderHistoryModel>> getOrderHistory() async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.get(
        url: EndPoints.baseUrl + EndPoints.orderHistoryEndPoint, token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(
        errorMessage: _data['message'] as String,
      );
    }
    return _data['data']['orders']
        .map((orderHistory) => OrderHistoryModel.fromJson(orderHistory))
        .toList()
        .cast<OrderHistoryModel>();
  }

  static Future<OrderModel> getOrderDetails({required int orderId}) async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.get(
        url: EndPoints.baseUrl +
            EndPoints.orderDetailsEndPoint(orderId: orderId),
        token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(
        errorMessage: _data['message'] as String,
      );
    }
    return OrderModel.fromJson(_data['data']);
  }
}
