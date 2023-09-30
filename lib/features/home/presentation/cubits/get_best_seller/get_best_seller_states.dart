import 'package:ketaby/features/home/data/models/book_model.dart';

abstract class GetBestSellerStates {}
class GetBestSellerInitialState extends GetBestSellerStates {}
class GetBestSellerLoadingState extends GetBestSellerStates {}
class GetBestSellerSuccessState extends GetBestSellerStates {
  final List<BookModel> bestSellerBooks;
  GetBestSellerSuccessState({required this.bestSellerBooks});
}
class GetBestSellerErrorState extends GetBestSellerStates {
  final String errorMessage;
  GetBestSellerErrorState({required this.errorMessage});
}