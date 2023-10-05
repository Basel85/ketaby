import 'package:ketaby/features/order_details/data/models/order_model.dart';

abstract class OrderDetailsStates {}
class OrderDetailsInitialState extends OrderDetailsStates {}
class OrderDetailsLoadingState extends OrderDetailsStates {}
class OrderDetailsSuccessState extends OrderDetailsStates {
  final OrderModel orderDetails;

  OrderDetailsSuccessState({required this.orderDetails});
}
class OrderDetailsErrorState extends OrderDetailsStates {
  final String errorMessage;
  OrderDetailsErrorState({required this.errorMessage});
}
