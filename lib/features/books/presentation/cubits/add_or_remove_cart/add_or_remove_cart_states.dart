abstract class AddOrRemoveCartStates {}
class AddOrRemoveCartInitialState extends AddOrRemoveCartStates{}
class AddOrRemoveCartLoadingState extends AddOrRemoveCartStates{}
class AddOrRemoveCartSuccessState extends AddOrRemoveCartStates{
  final String successMessage;

  AddOrRemoveCartSuccessState({required this.successMessage});
}
class AddOrRemoveCartErrorState extends AddOrRemoveCartStates{
  final String errorMessage;

  AddOrRemoveCartErrorState({required this.errorMessage});
}
