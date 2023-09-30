import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';

class GetSlidersRepository {
  static Future<List<Map<String, dynamic>>> getSliders() async {
    final data =
        await Api.get(url: EndPoints.baseUrl + EndPoints.getSlidersEndPoint);
    print(data['data']['sliders']);
    print("sUUII");
    return data['data']['sliders']
        .map((slider) => slider)
        .toList()
        .cast<Map<String, dynamic>>();
  }
}
