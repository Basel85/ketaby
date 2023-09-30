class CategoryModel {
  final int id;
  final String name;
  final int productsCount;

  CategoryModel({required this.id, required this.name, required this.productsCount});
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        name: json['name'],
        productsCount: json['products_count']);
  }
  
  Map<String, dynamic> toJson(CategoryModel categoryModel) {
    return {"id": 2, "name": "Software", "products_count": 29};
  }
}
