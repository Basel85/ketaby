import 'package:ketaby/features/home/data/models/book_model.dart';

abstract class GetNewArrivalsStates {}
class GetNewArrivalsInitialState extends GetNewArrivalsStates{}
class GetNewArrivalsLoadingState extends GetNewArrivalsStates{}
class GetNewArrivalsSuccessState extends GetNewArrivalsStates{
  final List<BookModel> newArrivalsBooks;
  GetNewArrivalsSuccessState({required this.newArrivalsBooks});
}
class GetNewArrivalsErrorState extends GetNewArrivalsStates{
  final String errorMessage;
  GetNewArrivalsErrorState({required this.errorMessage});
}
