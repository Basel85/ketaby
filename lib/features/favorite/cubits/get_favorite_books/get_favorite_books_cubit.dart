import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/favorite_repository.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_states.dart';

class GetFavoriteBooksCubit extends Cubit<GetFavoriteBooksStates> {
  GetFavoriteBooksCubit() : super(GetFavoriteBooksInitialState());
  static GetFavoriteBooksCubit get(context) => BlocProvider.of(context);
  void getFavoriteBooks({required int page}) async{
    try {
      emit(GetFavoriteBooksLoadingState());
      final favoriteBooks = await FavoriteRepository.getFavoriteBooks(page: page);
      emit(GetFavoriteBooksSuccessState(favoriteBooks: favoriteBooks));
    } on SocketException catch (_) {
      emit(GetFavoriteBooksErrorState(errorMessage: "No Internet Connection"));
    } on TimeoutException catch (_) {
      emit(
          GetFavoriteBooksErrorState(errorMessage: "Slow Internet Connection"));
    } catch (e) {
      emit(GetFavoriteBooksErrorState(errorMessage: e.toString()));
    }
  }
}
