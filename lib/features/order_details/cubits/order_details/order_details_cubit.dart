import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/order_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/order_details/cubits/order_details/order_details_states.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsStates> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());
  static OrderDetailsCubit get(context) => BlocProvider.of(context);
  void getOrderDetails({required int orderId}) async{
    try {
      emit(OrderDetailsLoadingState());
      final orderDetails = await OrderRepository.getOrderDetails(orderId: orderId);
      emit(OrderDetailsSuccessState(orderDetails: orderDetails));
    } on CustomException catch (exception) {
      emit(OrderDetailsErrorState(errorMessage: exception.toString()));
    } on TimeoutException catch (_) {
      emit(OrderDetailsErrorState(errorMessage: "Slow Internet Connection"));
    } on SocketException catch (_) {
      emit(OrderDetailsErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(OrderDetailsErrorState(errorMessage: "Something went wrong"));
    }
  }
}
