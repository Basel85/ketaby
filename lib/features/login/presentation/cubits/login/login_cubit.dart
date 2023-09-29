import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/login/data/repository/login_repository.dart';
import 'package:ketaby/features/login/presentation/cubits/login/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({required String email, required String password}) async{
    try {
      emit(LoginLoadingState());
      final data = await LoginRepository.login(email: email, password: password);
      // emit(LoginSuccessState(successMessage: ));
    } on SocketException catch (e) {
    } catch (_) {
      emit(LoginErrorState(error: "Something went wrong"));
    }
  }
}
