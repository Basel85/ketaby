import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/home/data/repositories/get_categories_repository.dart';
import 'package:ketaby/features/home/cubits/get_categories/get_categories_states.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesStates> {
  GetCategoriesCubit() : super(GetCategoriesInitialState());

  static GetCategoriesCubit get(context) => BlocProvider.of(context);

  void getCategories() async {
    try {
      emit(GetCategoriesLoadingState());
      final categories = await GetCategoriesRepository.getCategories();
      emit(GetCategoriesSuccessState(categories: categories));
    } on SocketException catch (_) {
      emit(GetCategoriesErrorState(errorMessage: "No Internet Connection"));
    } catch (e) {
      emit(GetCategoriesErrorState(errorMessage: e.toString()));
    }
  }
}
