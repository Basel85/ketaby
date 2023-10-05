
import 'package:ketaby/features/order_details/data/models/order_product_model.dart';

class OrderModel {
  final int id;
  final String orderCode;
  final String total;
  final String name;
  final String email;
  final String address;
  final String governorate;
  final String phone;
  final String? tax;
  final String subTotal;
  final String orderDate;
  final String status;
  final String? rejectDetails;
  final String? notes;
  final int discount;
  final List<OrderProductModel> orderProducts;

  OrderModel(
      {required this.id,
      required this.orderCode,
      required this.total,
      required this.name,
      required this.email,
      required this.address,
      required this.governorate,
      required this.phone,
      required this.tax,
      required this.subTotal,
      required this.orderDate,
      required this.status,
      required this.rejectDetails,
      required this.notes,
      required this.discount,
      required this.orderProducts});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json["id"],
        orderCode: json["order_code"],
        total: json["total"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        governorate: json["governorate"],
        phone: json["phone"],
        tax: json["tax"],
        subTotal: json["sub_total"],
        orderDate: json["order_date"],
        status: json["status"],
        rejectDetails: json["reject_details"],
        notes: json["notes"],
        discount: json["discount"],
        orderProducts: json["order_products"]
            .map((orderProduct) => OrderProductModel.fromJson(orderProduct))
            .toList()
            .cast<OrderProductModel>());
  }
  Map<String, dynamic> toJson() {
    return {
      "id": 163,
      "order_code": "00163",
      "total": "696.00",
      "name": "Ahmed Mohamed Hany",
      "email": "ahmedhany20200050@gmail.com",
      "address": "3bod",
      "governorate": "Giza",
      "phone": "01113677601",
      "tax": null,
      "sub_total": "696.00",
      "order_date": "2023-10-05",
      "status": "New",
      "reject_details": null,
      "notes": null,
      "discount": 0,
      "order_products": [
        {
          "order_product_id": 315,
          "product_id": 2,
          "product_name": "Clean Code",
          "product_price": "299.00",
          "product_discount": 40,
          "product_price_after_discount": 179.4,
          "order_product_quantity": 1,
          "product_total": "179.40"
        },
        {
          "order_product_id": 316,
          "product_id": 6,
          "product_name": "Head First Object-Oriented Analysis and Design",
          "product_price": "369.00",
          "product_discount": 30,
          "product_price_after_discount": 258.3,
          "order_product_quantity": 2,
          "product_total": "516.60"
        }
      ]
    };
  }
}
