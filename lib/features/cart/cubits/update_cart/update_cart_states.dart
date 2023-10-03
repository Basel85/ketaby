abstract class UpdateCartStates {}

class UpdateCartInitialState extends UpdateCartStates {}

class UpdateCartLoadingState extends UpdateCartStates {}

class UpdateCartSuccessState extends UpdateCartStates {
  final String successMessage;

  UpdateCartSuccessState({required this.successMessage});
}

class UpdateCartErrorState extends UpdateCartStates {
  final String errorMessage;

  UpdateCartErrorState({required this.errorMessage});
}
