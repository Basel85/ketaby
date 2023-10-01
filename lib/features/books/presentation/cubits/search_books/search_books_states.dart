import 'package:ketaby/core/data/models/book_model.dart';

abstract class SearchBooksStates {}
class SearchBooksInitialState extends SearchBooksStates {}
class SearchBooksLoadingState extends SearchBooksStates {}
class SearchBooksSuccessState extends SearchBooksStates {
  final List<BookModel> books;
  SearchBooksSuccessState({required this.books});
}
class SearchBooksErrorState extends SearchBooksStates {
  final String errorMessage;
  SearchBooksErrorState({required this.errorMessage});
}
