class AppRoute {
  final String name;
  final String path;

  const AppRoute({required this.name, required this.path});
}

class AppRouteConstants {
  static const authRoute = AppRoute(name: 'auth-screen', path: '/');

  static const bottomBarRoute = AppRoute(name: 'bottomBar', path: '/bottomBar');

  static const homeScreenRoute =
      AppRoute(name: 'home-screen', path: '/home-screen');

  static const searchScreenRoute =
      AppRoute(name: 'search-screen', path: '/search-screen');

  static const anotherScreenRoute =
      AppRoute(name: 'another-screen', path: '/another-screen');

  static const categoryproductsScreenRoute = AppRoute(
      name: 'category-products-screen', path: '/category-products-screen');

  static const menuScreenRoute =
      AppRoute(name: 'menu-screen', path: '/menu-screen');

  static const yourOrdersScreenRoute =
      AppRoute(name: 'your-orders', path: '/your-orders');

  static const searchOrdersScreenRoute =
      AppRoute(name: 'search-orders-screen', path: '/search-orders-screen');

  static const orderDetailsScreenRoute =
      AppRoute(name: 'order-details-screen', path: '/order-details-screen');

  static const yourWishListScreenRoute =
      AppRoute(name: 'your-wish-list-screen', path: '/your-wish-list-screen');

  static const browsingHistoryScreenRoute = AppRoute(
      name: 'browsing-history-screen', path: '/browsing-history-screen');

  static const productDetailsScreenRoute =
      AppRoute(name: 'product-details-screen', path: '/product-details-screen');

  // static const cartScreenScreenRoute =
  //     AppRoute(name: 'cart-screen', path: '/cart-screen');
}
