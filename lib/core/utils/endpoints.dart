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
  static String showWithList({required int page}) => "/wishlist?page=$page";
  static const String addToWishList = "/add-to-wishlist";
  static const String removeFromWishList = "/remove-from-wishlist";
  static const String showCartEndPoint = "/cart";
  static const String addToCartEndPoint = "/add-to-cart";
  static const String updateCartEndPoint = "/update-cart";
  static const String removeFromCartEndPoint = "/remove-from-cart";
}
