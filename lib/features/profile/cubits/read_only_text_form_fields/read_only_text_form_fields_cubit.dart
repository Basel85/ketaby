import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/profile/cubits/read_only_text_form_fields/read_only_text_form_fields_states.dart';

class ReadOnlyTextFormFieldsCubit extends Cubit<ReadOnlyTextFormFieldsStates> {
  ReadOnlyTextFormFieldsCubit() : super(ReadOnlyTextFormFieldsInitialState());
   static ReadOnlyTextFormFieldsCubit get(context) => BlocProvider.of(context);
  void changeReadOnlyValue() {
    emit(ReadOnlyTextFormFieldsChangedState());
  }
}
