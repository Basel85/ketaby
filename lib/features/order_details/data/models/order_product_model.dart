class OrderProductModel {
  final int orderProductId;
  final int productId;
  final String productName;
  final String productPrice;
  final int productDiscount;
  final String productPriceAfterDiscount;
  final int orderProductQuantity;
  final String productTotal;
  OrderProductModel({
    required this.orderProductId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDiscount,
    required this.productPriceAfterDiscount,
    required this.orderProductQuantity,
    required this.productTotal,
  });
  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      orderProductId: json["order_product_id"],
      productId: json["product_id"],
      productName: json["product_name"],
      productPrice: json["product_price"],
      productDiscount: json["product_discount"],
      productPriceAfterDiscount:
          double.parse(json["product_price_after_discount"].toString())
              .toStringAsFixed(2),
      orderProductQuantity: json["order_product_quantity"],
      productTotal: json["product_total"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "order_product_id": orderProductId,
      "product_id": productId,
      "product_name": productName,
      "product_price": productPrice,
      "product_discount": productDiscount,
      "product_price_after_discount": productPriceAfterDiscount,
      "order_product_quantity": orderProductQuantity,
      "product_total": productTotal
    };
  }
}
