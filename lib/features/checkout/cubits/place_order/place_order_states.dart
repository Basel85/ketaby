abstract class PlaceOrderStates {}

class PlaceOrderInitialState extends PlaceOrderStates {}

class PlaceOrderLoadingState extends PlaceOrderStates {}

class PlaceOrderSuccessState extends PlaceOrderStates {
  final String successMessage;

  PlaceOrderSuccessState({required this.successMessage});
}

class PlaceOrderErrorState extends PlaceOrderStates {
  final String errorMessage;
  final Map<String, dynamic>? errors;
  PlaceOrderErrorState({required this.errorMessage, this.errors});
}
