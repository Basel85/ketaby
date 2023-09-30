import 'package:ketaby/core/data/models/user_model.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {
  final String successMessage;
  final UserModel user;

  AuthSuccessState({required this.successMessage, required this.user});
}

class AuthErrorState extends AuthStates {
  final String errorMessage;
  final Map<String, dynamic> errors;
  AuthErrorState({this.errorMessage = "", this.errors = const {}});
}
