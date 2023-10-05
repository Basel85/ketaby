abstract class MakeTheUserAnOldUserStates {}

class MakeTheUserAnOldUserInitialState extends MakeTheUserAnOldUserStates {}

class MakeTheUserAnOldUserErrorState extends MakeTheUserAnOldUserStates {
  final String errorMessage;
  MakeTheUserAnOldUserErrorState({required this.errorMessage});
}
