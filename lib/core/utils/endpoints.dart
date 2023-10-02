class EndPoints {
  static const String baseUrl = 'https://codingarabic.online/api';
  static const String registerEndpoint = '/register';
  static const String loginEndPoint = '/login';
  static const String getSlidersEndPoint = '/sliders';
  static const String bestSellerEndPoint = "/products-bestseller";
  static const String newArrivalsEndPoint = "/products-new-arrivals";
  static const String categoriesEndPoint = "/categories";
  static const String booksEndPoint = "/products";
  static String searchBooksEndPoint({required String name}) =>
      "/products-search?name=$name";
  static const String showWithList = "/wishlist";
  static const String addToWishList = "/add-to-wishlist";
  static const String removeFromWishList = "/remove-from-wishlist";
}
