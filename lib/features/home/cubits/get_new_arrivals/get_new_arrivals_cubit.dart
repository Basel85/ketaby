import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/home/data/repositories/get_new_arrivals_repository.dart';
import 'package:ketaby/features/home/cubits/get_new_arrivals/get_new_arrivals_states.dart';

class GetNewArrivalsCubit extends Cubit<GetNewArrivalsStates> {
  GetNewArrivalsCubit() : super(GetNewArrivalsInitialState());

  static GetNewArrivalsCubit get(context) => BlocProvider.of(context);

  void getNewArrivals() async {
    try {
      emit(GetNewArrivalsLoadingState());
      final newArrivalsBooks = await GetNewArrivalsRepository.getNewArrivals();
      emit(GetNewArrivalsSuccessState(newArrivalsBooks: newArrivalsBooks));
    } on SocketException catch (_) {
      emit(GetNewArrivalsErrorState(errorMessage: "No Internet Connection"));
    } catch (e) {
      emit(GetNewArrivalsErrorState(errorMessage: e.toString()));
    }
  }
}
