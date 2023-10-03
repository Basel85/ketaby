import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/auth/auth_states.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/login/data/repository/login_repository.dart';
import 'package:ketaby/features/register/data/repo/register_repository.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  void login({required String email, required String password}) async {
    try {
      emit(AuthLoadingState());
      final user =
          await LoginRepository.login(email: email, password: password);
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
      {required String email,
      required String password,
      required String name,
      required String passwordConfirm}) async {
    try {
      emit(AuthLoadingState());
      final user = await RegisterRepository.register(
          email: email,
          password: password,
          name: name,
          passwordConfirm: passwordConfirm);
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
