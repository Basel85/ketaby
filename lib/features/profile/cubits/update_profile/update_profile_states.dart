
abstract class UpdateProfileStates {}

class UpdateProfileInitialState extends UpdateProfileStates {}

class UpdateProfileLoadingState extends UpdateProfileStates {}

class UpdateProfileSuccessState extends UpdateProfileStates {
  final Map<String,dynamic> user;

  UpdateProfileSuccessState({required this.user});
}

class UpdateProfileErrorState extends UpdateProfileStates {
  final String errorMessage;
  final Map<String, dynamic>? errors;
  UpdateProfileErrorState({required this.errorMessage, this.errors});
}
