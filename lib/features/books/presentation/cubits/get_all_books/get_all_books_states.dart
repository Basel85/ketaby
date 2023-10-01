import 'package:ketaby/core/data/models/book_model.dart';

abstract class GetAllBooksStates {}
class GetAllBooksInitialState extends GetAllBooksStates {}
class GetAllBooksLoadingState extends GetAllBooksStates {}
class GetAllBooksSuccessState extends GetAllBooksStates {
  final List<BookModel> books;
  GetAllBooksSuccessState(this.books);
}
class GetAllBooksErrorState extends GetAllBooksStates {
  final String errorMessage;
  GetAllBooksErrorState(this.errorMessage);
}