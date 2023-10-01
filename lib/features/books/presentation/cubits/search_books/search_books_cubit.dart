import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/get_books_repository.dart';
import 'package:ketaby/features/books/presentation/cubits/search_books/search_books_states.dart';

class SearchBooksCubit extends Cubit<SearchBooksStates> {
  SearchBooksCubit() : super(SearchBooksInitialState());

  static SearchBooksCubit get(context) => BlocProvider.of(context);

  void searchBooks({required String name}) async{
    try {
      emit(SearchBooksLoadingState());
      final books = await GetBooksRepository.searchBooks(name: name);
      emit(SearchBooksSuccessState(books: books));
    } on SocketException catch (_) {
      emit(SearchBooksErrorState(errorMessage: "No Internet Connection"));
    } on TimeoutException catch (_) {
      emit(SearchBooksErrorState(errorMessage: "Timeout Exception"));
    } catch (_) {
      emit(SearchBooksErrorState(errorMessage: "Something went wrong"));
    }
  }
}
