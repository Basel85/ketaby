class CartItemModel {
  final int itemId;
  final int itemProductId;
  final String itemProductName;
  final String itemProductImage;
  final String itemProductPrice;
  final int itemProductDiscount;
  final String itemProductPriceAfterDiscount;
  final int itemProductStock;
  final int itemQuantity;
  final double itemTotal;

  CartItemModel(
      {required this.itemId,
      required this.itemProductId,
      required this.itemProductName,
      required this.itemProductImage,
      required this.itemProductPrice,
      required this.itemProductDiscount,
      required this.itemProductPriceAfterDiscount,
      required this.itemProductStock,
      required this.itemQuantity,
      required this.itemTotal});
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        itemId: json['item_id'],
        itemProductId: json['item_product_id'],
        itemProductName: json['item_product_name'],
        itemProductImage: json['item_product_image'],
        itemProductPrice: json['item_product_price'],
        itemProductDiscount: json['item_product_discount'],
        itemProductPriceAfterDiscount:
            double.parse(json['item_product_price_after_discount'].toString())
                .toStringAsFixed(2),
        itemProductStock: json['item_product_stock'],
        itemQuantity: json['item_quantity'],
        itemTotal: json['item_total']);
  }
  Map<String, dynamic> toJson({required CartItemModel cartItemModel}) {
    return {
      "item_id": cartItemModel.itemId,
      "item_product_id": cartItemModel.itemProductId,
      "item_product_name": cartItemModel.itemProductName,
      "item_product_image": cartItemModel.itemProductImage,
      "item_product_price": cartItemModel.itemProductPrice,
      "item_product_discount": cartItemModel.itemProductDiscount,
      "item_product_price_after_discount":
          cartItemModel.itemProductPriceAfterDiscount,
      "item_product_stock": cartItemModel.itemProductStock,
      "item_quantity": cartItemModel.itemQuantity,
      "item_total": cartItemModel.itemTotal
    };
  }
}
