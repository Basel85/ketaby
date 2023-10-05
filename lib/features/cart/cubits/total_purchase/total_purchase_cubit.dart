import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/cart/cubits/total_purchase/total_purchase_states.dart';

class TotalPurchaseCubit extends Cubit<TotalPurchaseStates> {
  TotalPurchaseCubit() : super(TotalPurchaseInitialState());

  void updateTotalPurchase(double totalPurchase) {
    emit(TotalPurchaseChangedState());
  }
}