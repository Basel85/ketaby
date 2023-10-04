import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/order_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/checkout/cubits/place_order/place_order_states.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderStates> {
  PlaceOrderCubit() : super(PlaceOrderInitialState());
  static PlaceOrderCubit get(context) => BlocProvider.of(context);
  void placeOrder({required Map<String,dynamic> body}) async {
    try {
      emit(PlaceOrderLoadingState());
      await OrderRepository.placeOrder(body: body);
      emit(PlaceOrderSuccessState(successMessage: "order placed successfully"));
    } on CustomException catch (exception) {
      emit(PlaceOrderErrorState(errorMessage: exception.errorMessage,errors: exception.errors));
    } on TimeoutException catch (_) {
      emit(PlaceOrderErrorState(errorMessage: "Time out"));
    } on SocketException catch (_) {
      emit(PlaceOrderErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(PlaceOrderErrorState(
          errorMessage: "Something went wrong try again"));
    }
  }
}
