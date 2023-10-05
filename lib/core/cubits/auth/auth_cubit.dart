import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/auth/auth_states.dart';
import 'package:ketaby/core/data/repositories/auth_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';


class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
  

  void login({required Map<String,dynamic> body}) async {
    try {
      emit(AuthLoadingState());
      final user =
          await AuthRepository.login(body: body);
      emit(AuthSuccessState(successMessage: "Login Successfully", user: user));
    } on CustomException catch (authException) {
      emit(AuthErrorState(
          errorMessage: authException.errorMessage,
          errors: authException.errors));
    } on SocketException catch (_) {
      emit(AuthErrorState(errorMessage: "No internet connection"));
    } catch (_) {
      emit(AuthErrorState(errorMessage: "Something went wrong"));
    }
  }

  void register(
      {required Map<String,dynamic> body}) async {
    try {
      emit(AuthLoadingState());
      final user = await AuthRepository.register(body: body);
      emit(AuthSuccessState(
          successMessage: "Register Successfully", user: user));
    } on CustomException catch (authException) {
      emit(AuthErrorState(
          errorMessage: authException.errorMessage,
          errors: authException.errors));
    } on SocketException catch (_) {
      emit(AuthErrorState(errorMessage: "No internet connection"));
    } catch (_) {
      emit(AuthErrorState(errorMessage: "Something went wrong"));
    }
  }
}
