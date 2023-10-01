import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/data/models/book_model.dart';

class GetNewArrivalsRepository {
  static Future<List<BookModel>> getNewArrivals() async {
    final data =
        await Api.get(url: EndPoints.baseUrl + EndPoints.newArrivalsEndPoint);
    return data['data']['products']
        .map((book) => BookModel.fromJson(book))
        .toList()
        .cast<BookModel>();
  }
}
