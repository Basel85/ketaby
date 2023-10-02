import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/favorite_repository.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_states.dart';

class AddOrRemoveFavoriteCubit extends Cubit<AddOrRemoveFavoriteStates> {
  AddOrRemoveFavoriteCubit() : super(AddOrRemoveFavoriteInitialState());

  static AddOrRemoveFavoriteCubit get(context) => BlocProvider.of(context);

  void _perform({required Future<void> addOrRemoveFavorite}) async {
    try {
      emit(AddOrRemoveFavoriteLoadingState());
      await addOrRemoveFavorite;
      emit(AddOrRemoveFavoriteSuccessState(successMessage: "Book added to favorite successfully"));
    } on SocketException catch (_) {
      emit(AddOrRemoveFavoriteErrorState(
          errorMessage: "No Internet Connection"));
    } on TimeoutException catch (_) {
      emit(AddOrRemoveFavoriteErrorState(
          errorMessage: "Slow Internet Connection"));
    } catch (e) {
      emit(AddOrRemoveFavoriteErrorState(errorMessage: "Something went wrong"));
    }
  }

  void addToFavorite({required Map<String, dynamic> body}) {
    _perform(addOrRemoveFavorite: FavoriteRepository.addToFavorite(body: body));
  }

  void removeFromFavorite({required Map<String, dynamic> body}) {
    _perform(addOrRemoveFavorite: FavoriteRepository.removeFromFavorite(body: body));
  }
}
