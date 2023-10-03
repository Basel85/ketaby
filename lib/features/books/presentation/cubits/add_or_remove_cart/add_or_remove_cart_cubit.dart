import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_states.dart';

class AddOrRemoveCartCubit extends Cubit<AddOrRemoveCartStates> {
  AddOrRemoveCartCubit() : super(AddOrRemoveCartInitialState());
  static AddOrRemoveCartCubit get(context) => BlocProvider.of(context);
  void _performAddOrRemoveCart({required bool isAddToCartOperation}) {
    try {
      emit(AddOrRemoveCartLoadingState());
       
      emit(AddOrRemoveCartSuccessState(
          successMessage:
              "book ${isAddToCartOperation ? "added to" : "removed from"} cart successfully"));
    } on CustomException catch (e) {
      emit(AddOrRemoveCartErrorState(errorMessage: e.errorMessage));
    } on TimeoutException catch (_) {
      emit(AddOrRemoveCartErrorState(errorMessage: "Slow Internet Connection"));
    } on SocketException catch (_) {
      emit(AddOrRemoveCartErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(AddOrRemoveCartErrorState(errorMessage: "Something went wrong"));
    }
  }
  void addToCart() => _performAddOrRemoveCart(isAddToCartOperation: true);
  void removeFromCart() => _performAddOrRemoveCart(isAddToCartOperation: false);
}
