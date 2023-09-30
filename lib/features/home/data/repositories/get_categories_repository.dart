import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/features/home/data/models/category_model.dart';

class GetCategoriesRepository {
  static Future<List<CategoryModel>> getCategories() async {
    final data =
        await Api.get(url: EndPoints.baseUrl + EndPoints.categoriesEndPoint);
    return data['data']['categories']
        .map((category) => CategoryModel.fromJson(category))
        .toList()
        .cast<CategoryModel>();
  }
}
