import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/home/data/repositories/get_sliders_repository.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_states.dart';

class GetSlidersCubit extends Cubit<GetSlidersStates> {
  GetSlidersCubit() : super(GetSlidersInitialState());

  static GetSlidersCubit get(context) => BlocProvider.of(context);

  void getSliders() async {
    try {
      emit(GetSlidersLoadingState());
      final sliders = await GetSlidersRepository.getSliders();
      print("ayy");
      emit(GetSlidersSuccessState(sliders: sliders));
    } on SocketException catch (_) {
      emit(GetSlidersErrorState(errorMessage: "No Internet Connection"));
    } catch (e) {
      emit(GetSlidersErrorState(errorMessage: e.toString()));
    }
  }
}
