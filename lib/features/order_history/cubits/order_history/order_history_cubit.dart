import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/data/repositories/order_repository.dart';
import 'package:ketaby/core/utils/exceptions.dart';
import 'package:ketaby/features/order_history/cubits/order_history/order_history_states.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryStates> {
  OrderHistoryCubit() : super(OrderHistoryInitialState());

  static OrderHistoryCubit get(context) => BlocProvider.of(context);

  void getOrderHistory() async {
    try {
      emit(OrderHistoryLoadingState());
      final orderHistory = await OrderRepository.getOrderHistory();
      emit(OrderHistorySuccessState(orderHistory: orderHistory));
    } on CustomException catch (exception) {
      emit(OrderHistoryErrorState(errorMessage: exception.toString()));
    } on TimeoutException catch (_) {
      emit(OrderHistoryErrorState(errorMessage: "Slow Internet Connection"));
    } on SocketException catch (_) {
      emit(OrderHistoryErrorState(errorMessage: "No Internet Connection"));
    } catch (_) {
      emit(OrderHistoryErrorState(errorMessage: "Something went wrong"));
    }
  }
}
