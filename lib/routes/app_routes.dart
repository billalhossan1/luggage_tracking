class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  /////////////  initial or splash screen
  final String initial = "/";
  final String homeScreen = "/home-screen";
  final String categoryScreen = "/category-screen";
  final String productCategoryScreen = "/product-category-screen";
  final String productDetailsScreen = "/product-details-screen";
  final String navigationScreen = "/navigation-screen";
  final String deliveryDetainScreen = "/delivery-details-screen";
  final String deliveryDetainShowScreen = "/delivery-details-show-screen";
  final String paymentScreen = "/payment-screen";
}
