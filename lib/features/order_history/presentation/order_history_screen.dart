import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/order_details/presentation/order_details_screen.dart';
import 'package:ketaby/features/order_history/cubits/order_history/order_history_cubit.dart';
import 'package:ketaby/features/order_history/cubits/order_history/order_history_states.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});
  static const id = "OrderHistoryScreen";

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    OrderHistoryCubit.get(context).getOrderHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryStates>(
          builder: (_, state) {
        if (state is OrderHistorySuccessState) {
          return ListView.separated(
            itemCount: state.orderHistory.length,
            separatorBuilder: (_, __) => const Divider(),
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return OrderDetailsScreen(
                      orderId: state.orderHistory[index].id);
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Code: ${state.orderHistory[index].orderCode}'),
                  Text('Order Date: ${state.orderHistory[index].orderDate}'),
                  Text('Status: ${state.orderHistory[index].status}'),
                  Text('Total: \$${state.orderHistory[index].total}'),
                ],
              ),
            ),
          );
        } else if (state is OrderHistoryErrorState) {
          return GetErrorMessage(
              errorMessage: state.errorMessage,
              onPressed: () {
                OrderHistoryCubit.get(context).getOrderHistory();
              });
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      }),
    );
  }
}
