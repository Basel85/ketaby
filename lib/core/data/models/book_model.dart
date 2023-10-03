class BookModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int discount;
  final String priceAfterDiscount;
  final int stock;
  final int bestSeller;
  final String image;
  final String category;
  BookModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.discount,
      required this.priceAfterDiscount,
      required this.stock,
      required this.bestSeller,
      required this.image,
      required this.category});
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        discount: json['discount'],
        priceAfterDiscount: (double.parse(json['price'])-
            (double.parse(json['price']) * (json['discount'] / 100))).toStringAsFixed(2),
        stock: json['stock'],
        bestSeller: json['best_seller'],
        image: json['image'],
        category: json['category']);
  }
  Map<String, dynamic> toJson({required BookModel bookModel}) {
    return {
      "id": bookModel.id,
      "name": bookModel.name,
      "price": bookModel.price,
      "description": bookModel.description,
      "discount": bookModel.discount,
      "price_after_discount": bookModel.priceAfterDiscount,
      "stock": bookModel.stock,
      "best_seller": bookModel.bestSeller,
      "image": bookModel.image,
      "category": bookModel.category
    };
  }
}
