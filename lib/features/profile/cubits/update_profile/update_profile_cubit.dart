import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/profile/cubits/update_profile/update_profile_states.dart';
import 'package:ketaby/features/profile/data/repositories/profile_repository.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  UpdateProfileCubit() : super(UpdateProfileInitialState());

  static UpdateProfileCubit get(context) => BlocProvider.of(context);

  void updateProfile({required Map<String, dynamic> body}) async {
    try {
      emit(UpdateProfileLoadingState());
      final user = await ProfileRepository.updateProfile(body: body);
      emit(UpdateProfileSuccessState(user: user));
    } on SocketException catch (e) {
      emit(UpdateProfileErrorState(errorMessage: e.toString()));
    } on TimeoutException catch (e) {
      emit(UpdateProfileErrorState(errorMessage: e.toString()));
    } on CustomException catch (e) {
      emit(UpdateProfileErrorState(
          errorMessage: e.errorMessage, errors: e.errors));
    } catch (e) {
      emit(UpdateProfileErrorState(errorMessage: e.toString()));
    }
  }
}
