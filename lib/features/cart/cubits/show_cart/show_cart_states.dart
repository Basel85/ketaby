import 'package:ketaby/features/cart/data/models/cart_model.dart';

abstract class ShowCartStates {}
class ShowCartInitialState extends ShowCartStates {}
class ShowCartLoadingState extends ShowCartStates {}
class ShowCartSuccessState extends ShowCartStates {
  final CartModel cart;
  ShowCartSuccessState({required this.cart});
}
class ShowCartErrorState extends ShowCartStates {
  final String errorMessage;
  ShowCartErrorState({required this.errorMessage});
}
