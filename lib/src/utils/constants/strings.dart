import 'package:flutter_dotenv/flutter_dotenv.dart';

final secureUri = dotenv.env['URI'];
String uri = secureUri!;

String signUpUrl = '$uri/api/signup';
String signInUrl = '$uri/api/signin';
String fetchCategoryProductsUri = '$uri/api/products?category=';
String searchProductsUri = '$uri/api/products/search';
String fetchMyOrdersUri = '$uri/api/orders/me';
String searchOrdersUri = '$uri/api/orders/search';
String getProductRatingUri = '$uri/api/get-product-rating';
String getAverageRatingUri = '$uri/api/get-ratings-average';
String rateProductUri = '$uri/api/rate-product';
String addKeepShoppingForUri = '$uri/api/add-keep-shopping-for';
String getKeepShoppingForUri = '$uri/api/get-keep-shopping-for';
String getWishListUri = '$uri/api/get-wish-list';
String addToWishListUri = '$uri/api/add-to-wish-list';
String removeFromWishListUri = '$uri/api/delete-from-wish-list';
String isWishListedUri = '$uri/api/is-wishlisted';

String addToCartFromWishListUri = '$uri/api/add-to-cart-from-wish-list';

String getCartUri = '$uri/api/get-cart';
String addToCartUri = '$uri/api/add-to-cart';
String removeFromCartUri = '$uri/api/remove-from-cart';
String deleteFromCartUri = '$uri/api/delete-from-cart';

String saveForLaterUri = '$uri/api/save-for-later';
String getSaveForLaterUri = '$uri/api/get-save-for-later';
String deleteFromLaterUri = '$uri/api/delete-from-later';
String moveToCartUri = '$uri/api/move-to-cart';
