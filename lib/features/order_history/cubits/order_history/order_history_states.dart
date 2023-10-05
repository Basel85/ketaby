import 'package:ketaby/features/order_history/data/models/order_history_model.dart';

abstract class OrderHistoryStates {}
class OrderHistoryInitialState extends OrderHistoryStates {}
class OrderHistoryLoadingState extends OrderHistoryStates {}
class OrderHistorySuccessState extends OrderHistoryStates {
  final List<OrderHistoryModel> orderHistory;
  OrderHistorySuccessState({required this.orderHistory});
}
class OrderHistoryErrorState extends OrderHistoryStates {
  final String errorMessage;
  OrderHistoryErrorState({required this.errorMessage});
}