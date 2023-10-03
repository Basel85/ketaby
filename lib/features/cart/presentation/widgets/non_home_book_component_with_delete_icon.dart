import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/api_image.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_states.dart';
import 'package:ketaby/features/cart/cubits/counter/counter_cubit.dart';
import 'package:ketaby/features/cart/cubits/counter/counter_states.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/update_cart/update_cart_cubit.dart';

class NonHomeBookComponentWithDeleteIcon extends StatefulWidget {
  const NonHomeBookComponentWithDeleteIcon({super.key, required this.cartItem});
  final Map<String, dynamic> cartItem;

  @override
  State<NonHomeBookComponentWithDeleteIcon> createState() =>
      _NonHomeBookComponentWithDeleteIconState();
}

class _NonHomeBookComponentWithDeleteIconState
    extends State<NonHomeBookComponentWithDeleteIcon> with SnackBarViewer {
  int _quantity = 0;
  Map<String, dynamic> _updateCartbody = {};
  @override
  void initState() {
    _quantity = int.parse(widget.cartItem['item_quantity'].toString());
    _updateCartbody = {
      'cart_item_id': widget.cartItem['item_id'].toString(),
      'quantity': (_quantity).toString()
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.5))),
      child: Row(
        children: [
          SizedBox(
              width: 75,
              child: ApiImage(
                  imageUrl: widget.cartItem['item_product_image'].toString())),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.cartItem['item_product_name'].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 18),
                      ),
                    ),
                    BlocConsumer<AddOrRemoveCartCubit, AddOrRemoveCartStates>(
                      listener: (context, state) {
                        if (state is AddOrRemoveCartSuccessState) {
                          showSnackBar(
                              context: context,
                              message: state.successMessage,
                              backgroundColor: Colors.green);
                          ShowCartCubit.get(context).showCart();
                        } else if (state is AddOrRemoveCartErrorState) {
                          showSnackBar(
                              context: context,
                              message: state.errorMessage,
                              backgroundColor: Colors.red);
                        }
                      },
                      builder: (_, state) =>
                          state is AddOrRemoveCartLoadingState
                              ? const CircularProgressIndicator.adaptive()
                              : IconButton(
                                  onPressed: () {
                                    AddOrRemoveCartCubit.get(context)
                                        .removeFromCart(body: {
                                      'cart_item_id':
                                          widget.cartItem['item_id'].toString()
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _quantity++;
                                CounterCubit.get(context).changeValue();
                                _updateCartbody['quantity'] =
                                    (_quantity).toString();

                                UpdateCartCubit.get(context)
                                    .updateCart(body: _updateCartbody);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              )),
                          BlocBuilder<CounterCubit, CounterStates>(
                            builder: (_, __) => Text(
                              "$_quantity",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (_quantity > 1) {
                                  _quantity--;
                                  CounterCubit.get(context).changeValue();
                                  _updateCartbody['quantity'] =
                                      (_quantity).toString();
                                  UpdateCartCubit.get(context)
                                      .updateCart(body: _updateCartbody);
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${widget.cartItem['item_product_price'].toString()} L.E",
                          style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey),
                        ),
                        Text(
                          "${widget.cartItem['item_product_price_after_discount'].toString()} L.E",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
