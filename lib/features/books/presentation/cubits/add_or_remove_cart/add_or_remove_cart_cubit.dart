import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/cart_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_states.dart';

class AddOrRemoveCartCubit extends Cubit<AddOrRemoveCartStates> {
  AddOrRemoveCartCubit() : super(AddOrRemoveCartInitialState());
  static AddOrRemoveCartCubit get(context) => BlocProvider.of(context);
  void _performAddOrRemoveCart({required bool isAddToCartOperation,required Future<void> performAddOrRemoveOperation}) async{
    try {
      emit(AddOrRemoveCartLoadingState());
      await performAddOrRemoveOperation;
      emit(AddOrRemoveCartSuccessState(
          successMessage:
              "book ${isAddToCartOperation ? "added to" : "removed from"} cart successfully"));
    } on CustomException catch (exception) {
      emit(AddOrRemoveCartErrorState(errorMessage: exception.errorMessage));
    } on TimeoutException catch (_) {
      emit(AddOrRemoveCartErrorState(errorMessage: "Slow Internet Connection"));
    } on SocketException catch (_) {
      emit(AddOrRemoveCartErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(AddOrRemoveCartErrorState(errorMessage: "Something went wrong"));
    }
  }
  void addToCart({required Map<String,dynamic> body}) => _performAddOrRemoveCart(isAddToCartOperation: true,performAddOrRemoveOperation: CartRepository.addToCart(body: body));
  void removeFromCart({required Map<String,dynamic> body}) => _performAddOrRemoveCart(isAddToCartOperation: false,performAddOrRemoveOperation: CartRepository.removeFromCart(body: body));
}
