abstract class PasswordVisibilityStates {}

class PasswordVisibilityInitialState extends PasswordVisibilityStates {}

class PasswordVisibilityChangeState extends PasswordVisibilityStates {
  final int index;

  PasswordVisibilityChangeState({required this.index});
}
