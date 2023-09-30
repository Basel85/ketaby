abstract class GetSlidersStates {}

class GetSlidersInitialState extends GetSlidersStates {}

class GetSlidersLoadingState extends GetSlidersStates {}

class GetSlidersSuccessState extends GetSlidersStates {
  final List<Map<String, dynamic>> sliders;
  GetSlidersSuccessState({required this.sliders});
}

class GetSlidersErrorState extends GetSlidersStates {
  final String errorMessage;
  GetSlidersErrorState({required this.errorMessage});
}
