import 'package:ketaby/features/home/data/models/category_model.dart';

abstract class GetCategoriesStates {}
class GetCategoriesInitialState extends GetCategoriesStates {}
class GetCategoriesLoadingState extends GetCategoriesStates {}
class GetCategoriesSuccessState extends GetCategoriesStates {
  final List<CategoryModel> categories;
  GetCategoriesSuccessState({required this.categories});
}
class GetCategoriesErrorState extends GetCategoriesStates {
  final String errorMessage;
  GetCategoriesErrorState({required this.errorMessage});
}
