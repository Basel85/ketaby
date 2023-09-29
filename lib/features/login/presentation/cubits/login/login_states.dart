abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String successMessage;

  LoginSuccessState({required this.successMessage});
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState({required this.error});
}
