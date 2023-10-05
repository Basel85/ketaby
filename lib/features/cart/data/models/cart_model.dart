import 'package:ketaby/features/cart/data/models/cart_item_model.dart';

class CartModel {
  final String total;
  final List<CartItemModel> cartItems;

  CartModel({required this.total, required this.cartItems});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        total: json['total'],
        cartItems: json['cart_items']
            .map<CartItemModel>((cartItem) => CartItemModel.fromJson(cartItem))
            .toList()
            .cast<CartItemModel>());
  }
  Map<String,dynamic> toJson(){
    return {
      'total':total,
      'cart_items':cartItems.map((cartItem) => cartItem.toJson()).toList()
    };
  }
}
