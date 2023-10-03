import 'package:flutter/material.dart';
import 'package:ketaby/core/widgets/api_image.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_cart/add_or_remove_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/update_cart/update_cart_cubit.dart';

class NonHomeBookComponentWithDeleteIcon extends StatefulWidget {
  const NonHomeBookComponentWithDeleteIcon({super.key, required this.cartItem});
  final Map<String, dynamic> cartItem;

  @override
  State<NonHomeBookComponentWithDeleteIcon> createState() =>
      _NonHomeBookComponentWithDeleteIconState();
}

class _NonHomeBookComponentWithDeleteIconState
    extends State<NonHomeBookComponentWithDeleteIcon> {
  int _quantity = 0;
  @override
  void initState() {
    _quantity = int.parse(widget.cartItem['item_quantity'].toString());
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
                    Text(
                      widget.cartItem['item_product_name'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          AddOrRemoveCartCubit.get(context).removeFromCart(
                              body: {
                                'cart_item_id':
                                    widget.cartItem['item_id'].toString()
                              });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
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
                                UpdateCartCubit.get(context).updateCart({
                                  'cart_item_id':
                                      widget.cartItem['item_id'].toString(),
                                  'quantity': (_quantity + 1).toString()
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              )),
                          Text(
                            "$_quantity",
                            style: const TextStyle(color: Colors.black),
                          ),
                          IconButton(
                              onPressed: () {},
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
