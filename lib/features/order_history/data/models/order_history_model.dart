class OrderHistoryModel {
  final int id;
  final String orderCode;
  final String orderDate;
  final String status;
  final String total;

  OrderHistoryModel(
      {required this.id,
      required this.orderCode,
      required this.orderDate,
      required this.status,
      required this.total});
  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
        id: json['id'],
        orderCode: json['order_code'],
        orderDate: json['order_date'],
        status: json['status'],
        total: json['total']);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": 166,
      "order_code": "00166",
      "order_date": "2023-10-05",
      "status": "New",
      "total": "585.90"
    };
  }
}
