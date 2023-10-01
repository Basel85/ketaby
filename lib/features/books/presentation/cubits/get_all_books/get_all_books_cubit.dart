import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/get_books_repository.dart';
import 'package:ketaby/features/books/presentation/cubits/get_all_books/get_all_books_states.dart';

class GetAllBooksCubit extends Cubit<GetAllBooksStates> {
  GetAllBooksCubit() : super(GetAllBooksInitialState());
  static GetAllBooksCubit get(context) => BlocProvider.of(context);
  void getAllBooks() async {
    try {
      emit(GetAllBooksLoadingState());
      final books = await GetBooksRepository.getAllBooks();
      emit(GetAllBooksSuccessState(books));
    } on SocketException catch (_) {
      emit(GetAllBooksErrorState('No Internet Connection'));
    } on TimeoutException catch (_) {
      emit(GetAllBooksErrorState('Timeout'));
    } catch (e) {
      emit(GetAllBooksErrorState(e.toString()));
    }
  }
}
