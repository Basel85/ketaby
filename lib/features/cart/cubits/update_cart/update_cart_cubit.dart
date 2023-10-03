import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/cart_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/cart/cubits/update_cart/update_cart_states.dart';

class UpdateCartCubit extends Cubit<UpdateCartStates> {
  UpdateCartCubit() : super(UpdateCartInitialState());
  static UpdateCartCubit get(context) => BlocProvider.of(context);
  void updateCart({required Map<String,dynamic> body}) async{
    try {
      emit(UpdateCartLoadingState());
      await CartRepository.updateCart(body: body);
      emit(UpdateCartSuccessState(successMessage: "Cart updated successfully"));
    } on CustomException catch (exception) {
      emit(UpdateCartErrorState(errorMessage: exception.errorMessage));
    } on TimeoutException catch (_) {
      emit(UpdateCartErrorState(errorMessage: "Slow Internet Connection"));
    } on SocketException catch (_) {
      emit(UpdateCartErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(UpdateCartErrorState(errorMessage: "Something went wrong"));
    }
  }
}
