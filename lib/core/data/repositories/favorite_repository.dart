import 'package:ketaby/core/data/models/book_model.dart';
import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';

class FavoriteRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static String _token = "";
  static Map<String, dynamic> _data = {};
  static Future<void> _performAddOrRemoveOperation(
      {required String endPoint, required Map<String, dynamic> body}) async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.post(
        url: EndPoints.baseUrl + endPoint, body: body, token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(errorMessage: _data['message'] as String);
    }
  }

  static Future<void> addToFavorite(
      {required Map<String, dynamic> body}) async {
    return await _performAddOrRemoveOperation(endPoint: EndPoints.addToWishList, body: body);
  }

  static Future<void> removeFromFavorite(
      {required Map<String, dynamic> body}) async {
    return await _performAddOrRemoveOperation(endPoint: EndPoints.removeFromWishList, body: body);
  }

  static Future<List<BookModel>> getFavoriteBooks({required int page}) async {
    _token = await _cacheHelper.getData(key: 'token');
    _data = await Api.get(url: EndPoints.baseUrl + EndPoints.showWithList(page: page), token: _token);
    if (_data['status'] != 200 && _data['status'] != 201) {
      throw CustomException(errorMessage: _data['message'] as String);
    }
    return _data['data']['data']
        .map((book) {
          return BookModel.fromJson(book);
        })
        .toList()
        .cast<BookModel>();
  }
}
