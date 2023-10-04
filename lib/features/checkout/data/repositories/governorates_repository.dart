import 'package:ketaby/core/helpers/api.dart';
import 'package:ketaby/core/utils/endpoints.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/checkout/data/models/governorate_model.dart';

class GovernoratesRepository {
  static Map<String, dynamic> _data = {};
  static Future<List<GovernorateModel>> getGovernorates() async {
    _data =
        await Api.get(url: EndPoints.baseUrl + EndPoints.governoratesEndPoint);
    if (_data['status'] != 200 && _data['error'] == 201) {
      throw CustomException(errorMessage: _data['message'] as String);
    }
    return _data['data']
        .map((governorate) => GovernorateModel.fromJson(governorate))
        .toList()
        .cast<GovernorateModel>();
  }
}
