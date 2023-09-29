abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String successMessage;

  RegisterSuccessState({required this.successMessage});
}

class RegisterErrorState extends RegisterStates {
  
}
