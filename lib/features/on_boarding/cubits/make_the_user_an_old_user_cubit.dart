import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/on_boarding/cubits/make_the_user_an_old_user_states.dart';
import 'package:ketaby/features/on_boarding/data/repositories/make_the_user_an_old_user_repository.dart';

class MakeTheUserAnOldUserCubit extends Cubit<MakeTheUserAnOldUserStates> {
  MakeTheUserAnOldUserCubit() : super(MakeTheUserAnOldUserInitialState());
  static MakeTheUserAnOldUserCubit get(context) => BlocProvider.of(context);
  Future<void> makeTheUserAnOldUser() async{
    try {
      MakeTheUserAnOldUserRepository.makeTheUserAnOldUser();
    } catch (e) {
      emit(MakeTheUserAnOldUserErrorState(errorMessage: e.toString()));
    }
  }
}
