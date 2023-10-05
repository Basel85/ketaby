import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/order_details/cubits/order_details/order_details_cubit.dart';
import 'package:ketaby/features/order_details/cubits/order_details/order_details_states.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});
  static const id = "OrderDetailsScreen";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    OrderDetailsCubit.get(context).getOrderDetails(orderId: widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<OrderDetailsCubit, OrderDetailsStates>(builder: (_, state) {
      if (state is OrderDetailsSuccessState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Code: ${state.orderDetails.orderCode}'),
            Text('Total: \$${state.orderDetails.total}'),
            Text('Name: ${state.orderDetails.name}'),
            Text('Email: ${state.orderDetails.email}'),
            Text('Address: ${state.orderDetails.address}'),
            Text('Governorate: ${state.orderDetails.governorate}'),
            Text('Phone: ${state.orderDetails.phone}'),
            Text('Order Date: ${state.orderDetails.orderDate}'),
            Text('Status: ${state.orderDetails.status}'),
            Text('Discount: ${state.orderDetails.discount}%'),
            Text('Sub Total: \$${state.orderDetails.subTotal}'),
            const SizedBox(height: 10),
            const Text('Ordered Products:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.orderDetails.orderProducts.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title:
                      Text(state.orderDetails.orderProducts[index].productName),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${state.orderDetails.orderProducts[index].productPrice}'),
                          Text('Discount: ${state.orderDetails.orderProducts[index].productPriceAfterDiscount}%'),
                          Text('Quantity: ${state.orderDetails.orderProducts[index].orderProductQuantity}'),
                          Text('Total: \$${state.orderDetails.orderProducts[index].productTotal}'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      } else if (state is OrderDetailsErrorState) {
        return GetErrorMessage(
            errorMessage: state.errorMessage,
            onPressed: () {
              OrderDetailsCubit.get(context)
                  .getOrderDetails(orderId: widget.orderId);
            });
      } else {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
    }));
  }
}
