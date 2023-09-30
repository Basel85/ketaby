import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';

class GetSlidersRepository {
  static Future<List<Map<String, String>>> getSliders() async {
    final data =
        await Api.get(url: EndPoints.baseUrl + EndPoints.getSlidersEndPoint);
    return data['data']['sliders'];
  }
}
