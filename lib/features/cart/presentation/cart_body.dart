import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/counter/counter_cubit.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_states.dart';
import 'package:ketaby/features/cart/presentation/widgets/non_home_book_component_with_delete_icon.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  void initState() {
    ShowCartCubit.get(context).showCart();
    super.initState();
  }

  Map<String, dynamic> _cartItem = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<ShowCartCubit, ShowCartStates>(
      builder: (context, state) {
        if (state is ShowCartSuccessState) {
          if (state.cart.cartItems.isEmpty) {
            return const Center(
              child: Text("No items in your cart"),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        _cartItem = state.cart.cartItems[index]
                            .toJson(cartItemModel: state.cart.cartItems[index]);

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
                      Text(
                        "total price: ${state.cart.total} L.E",
                        style: const TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ))
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
