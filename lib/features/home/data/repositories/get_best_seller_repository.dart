import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/features/home/data/models/book_model.dart';

class GetBestSellerRepository {
  static Future<List<BookModel>> getBestSeller() async {
    final data =
        await Api.get(url: EndPoints.baseUrl + EndPoints.bestSellerEndPoint);
    return data['data']['products']
        .map((book) => BookModel.fromJson(book))
        .toList()
        .cast<BookModel>();
  }
}
