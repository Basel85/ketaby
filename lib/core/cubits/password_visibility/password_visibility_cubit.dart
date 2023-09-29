import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_states.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityStates> {
  PasswordVisibilityCubit() : super(PasswordVisibilityInitialState());

  static PasswordVisibilityCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility({required int index}) {
    emit(PasswordVisibilityChangeState(index: index));
  }
}
