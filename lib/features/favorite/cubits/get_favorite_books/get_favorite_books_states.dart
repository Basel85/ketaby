import 'package:ketaby/core/data/models/book_model.dart';

abstract class GetFavoriteBooksStates {}
class GetFavoriteBooksInitialState extends GetFavoriteBooksStates {}
class GetFavoriteBooksLoadingState extends GetFavoriteBooksStates {}
class GetFavoriteBooksSuccessState extends GetFavoriteBooksStates {
  final List<BookModel> favoriteBooks;
  GetFavoriteBooksSuccessState({required this.favoriteBooks});
}
class GetFavoriteBooksErrorState extends GetFavoriteBooksStates {
  final String errorMessage;
  GetFavoriteBooksErrorState({required this.errorMessage});
}
