import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/register/data/repo/register_repo.dart';
import 'package:ketaby/features/register/presentation/cubits/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register(
      {required String email,
      required String password,
      required String name,
      required String passwordConfirm}) async {
    try {
      emit(RegisterLoadingState());
      final data = await RegisterRepository.register(
          email: email, password: password, name: name, passwordConfirm: passwordConfirm);
      emit(RegisterSuccessState(successMessage: data['message']));
    } catch (_) {
      emit(RegisterErrorState(error: "Something went wrong"));
    }
  }
}
