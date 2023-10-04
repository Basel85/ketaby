import 'package:ketaby/features/checkout/data/models/governorate_model.dart';

abstract class GetGovernoratesStates {}
class GetGovernoratesInitialState extends GetGovernoratesStates {}
class GetGovernoratesLoadingState extends GetGovernoratesStates {}
class GetGovernoratesSuccessState extends GetGovernoratesStates {
  final List<GovernorateModel> governorates;

  GetGovernoratesSuccessState({required this.governorates});
}
class GetGovernoratesErrorState extends GetGovernoratesStates {
  final String errorMessage;

  GetGovernoratesErrorState({required this.errorMessage});
}