import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/checkout/cubits/get_governorates/get_governorates_states.dart';
import 'package:ketaby/features/checkout/data/repositories/governorates_repository.dart';

class GetGovernoratesCubit extends Cubit<GetGovernoratesStates> {
  GetGovernoratesCubit() : super(GetGovernoratesInitialState());
  static GetGovernoratesCubit get(context) => BlocProvider.of(context);
  void getGovernorates() async{
    try {
      emit(GetGovernoratesLoadingState());
      final governorates = await GovernoratesRepository.getGovernorates();
      emit(GetGovernoratesSuccessState(governorates: governorates));
    } on CustomException catch (exception) {
      emit(GetGovernoratesErrorState(errorMessage: exception.errorMessage));
    } on TimeoutException catch (_) {
      emit(GetGovernoratesErrorState(errorMessage: "Time out"));
    } on SocketException catch (_) {
      emit(GetGovernoratesErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(GetGovernoratesErrorState(
          errorMessage: "Something went wrong try again"));
    }
  }
}
