
abstract class AddOrRemoveFavoriteStates {}

class AddOrRemoveFavoriteInitialState extends AddOrRemoveFavoriteStates {}

class AddOrRemoveFavoriteLoadingState extends AddOrRemoveFavoriteStates {}

class AddOrRemoveFavoriteSuccessState extends AddOrRemoveFavoriteStates {
  final String successMessage;

  AddOrRemoveFavoriteSuccessState({required this.successMessage});
}

class AddOrRemoveFavoriteErrorState extends AddOrRemoveFavoriteStates {
  final String errorMessage;
  AddOrRemoveFavoriteErrorState({required this.errorMessage});
}


