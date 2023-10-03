import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/cart_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_states.dart';

class ShowCartCubit extends Cubit<ShowCartStates> {
  ShowCartCubit() : super(ShowCartInitialState());
  static ShowCartCubit get(context) => BlocProvider.of(context);
  void showCart() async{
    try {
      emit(ShowCartLoadingState());
      final cart = await CartRepository.showCart();
      emit(ShowCartSuccessState(cart: cart));
    } on CustomException catch (exception) {
      emit(ShowCartErrorState(errorMessage: exception.errorMessage));
    } on TimeoutException catch (_) {
      emit(ShowCartErrorState(errorMessage: "Slow Internet Connection"));
    } on SocketException catch (_) {
      emit(ShowCartErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(ShowCartErrorState(errorMessage: "Something went wrong"));
    }
  }
}
