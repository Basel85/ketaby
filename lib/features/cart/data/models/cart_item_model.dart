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
  final String itemTotal;

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
        itemTotal: double.parse(json['item_total'].toString()).toStringAsFixed(2));
  }
  Map<String, dynamic> toJson() {
    return {
      "item_id": itemId,
      "item_product_id": itemProductId,
      "item_product_name": itemProductName,
      "item_product_image": itemProductImage,
      "item_product_price": itemProductPrice,
      "item_product_discount": itemProductDiscount,
      "item_product_price_after_discount":
          itemProductPriceAfterDiscount,
      "item_product_stock": itemProductStock,
      "item_quantity": itemQuantity,
      "item_total": itemTotal
    };
  }
}
