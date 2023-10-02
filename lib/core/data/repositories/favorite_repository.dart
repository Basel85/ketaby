import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';

class FavoriteRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static String _token = "";
  static Future<void> _perform(
      {required String endPoint, required Map<String, dynamic> body}) async {
        _token = await _cacheHelper.getData(key: 'token');
    await Api.post(
        url: EndPoints.baseUrl + endPoint,
        body: body,
        token: _token);
  }

  static Future<void> addToFavorite(
      {required Map<String, dynamic> body}) async {
    return await _perform(endPoint: EndPoints.addToWishList, body: body);
  }

  static Future<void> removeFromFavorite(
      {required Map<String, dynamic> body}) async {
    return await _perform(endPoint: EndPoints.removeFromWishList, body: body);
  }
}
