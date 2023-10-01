import 'package:ketaby/core/data/models/book_model.dart';
import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';

class GetBooksRepository {
  static Future<List<BookModel>> _getBooks({required String endPoint}) async {
    final data = await Api.get(url: EndPoints.baseUrl + endPoint);
    return data['data']['products']
        .map((book) => BookModel.fromJson(book))
        .toList()
        .cast<BookModel>();
  }

  static Future<List<BookModel>> getAllBooks() async {
    return await _getBooks(endPoint: EndPoints.booksEndPoint);
  }
  static Future<List<BookModel>> searchBooks({required String name}) async{
    return await _getBooks(endPoint: EndPoints.searchBooksEndPoint(name: name));
  }
}
