import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/counter/counter_cubit.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_states.dart';
import 'package:ketaby/features/cart/cubits/total_purchase/total_purchase_cubit.dart';
import 'package:ketaby/features/cart/cubits/total_purchase/total_purchase_states.dart';
import 'package:ketaby/features/cart/cubits/update_cart/update_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/update_cart/update_cart_states.dart';
import 'package:ketaby/features/cart/presentation/widgets/non_home_book_component_with_delete_icon.dart';
import 'package:ketaby/features/checkout/presentation/checkout_screen.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> with SnackBarViewer {
  @override
  void initState() {
    ShowCartCubit.get(context).showCart();
    super.initState();
  }

  Map<String, dynamic> _cartItem = {};
  double _totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<ShowCartCubit, ShowCartStates>(
      builder: (context, state) {
        if (state is ShowCartSuccessState) {
          if (state.cart.cartItems.isEmpty) {
            return GetErrorMessage(
                errorMessage: "No Items in the cart",
                onPressed: () {
                  ShowCartCubit.get(context).showCart();
                });
          }
          _totalPrice = double.parse(state.cart.total.toString());
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        _cartItem = state.cart.cartItems[index].toJson();
                        return BlocProvider(
                          create: (context) => CounterCubit(),
                          child: BlocProvider<AddOrRemoveCartCubit>(
                            create: (context) => AddOrRemoveCartCubit(),
                            child: NonHomeBookComponentWithDeleteIcon(
                                cartItem: _cartItem),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: state.cart.cartItems.length),
                ),
                CustomButton(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<TotalPurchaseCubit, TotalPurchaseStates>(
                        builder: (_, __) => Text(
                          "total price: ${_totalPrice.toStringAsFixed(2)} L.E",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      BlocConsumer<UpdateCartCubit, UpdateCartStates>(
                        listener: (context, updateCartState) {
                          if (updateCartState is UpdateCartSuccessState) {
                            showSnackBar(
                                context: context,
                                message: updateCartState.successMessage,
                                backgroundColor: Colors.green);
                            ShowCartCubit.get(context).showCart();
                          } else if (updateCartState is UpdateCartErrorState) {
                            showSnackBar(
                                context: context,
                                message: updateCartState.errorMessage,
                                backgroundColor: Colors.red);
                          }
                        },
                        listenWhen: (previous, current) =>
                            current is UpdateCartSuccessState ||
                            current is UpdateCartErrorState,
                        builder: (_, updateCartState) =>
                            updateCartState is UpdateCartLoadingState
                                ? const CircularProgressIndicator.adaptive()
                                : ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CheckoutScreen(
                                                    cart: state.cart.toJson(),
                                                  )));
                                    },
                                    child: Text(
                                      "Checkout",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (state is ShowCartErrorState) {
          return GetErrorMessage(
            errorMessage: state.errorMessage,
            onPressed: () => ShowCartCubit.get(context).showCart(),
          );
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    ));
  }
}
