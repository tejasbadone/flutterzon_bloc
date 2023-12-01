import 'package:flutter_dotenv/flutter_dotenv.dart';

final secureUri = dotenv.env['URI'];
String uri = secureUri!;

String signUpUrl = '$uri/api/signup';
String signInUrl = '$uri/api/signin';
String isTokenValidUri = '$uri/IsTokenValid';

String fetchCategoryProductsUri = '$uri/api/products?category=';
String searchProductsUri = '$uri/api/products/search';
String fetchMyOrdersUri = '$uri/api/orders/me';
String searchOrdersUri = '$uri/api/orders/search';
String getProductRatingUri = '$uri/api/get-product-rating';
String getAverageRatingUri = '$uri/api/get-ratings-average';
String rateProductUri = '$uri/api/rate-product';
String getAverageRatingLengthUri = '$uri/api/get-average-ratings-length';
String getDealOfTheDayUri = '$uri/api/deal-of-the-day';

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

String saveUserAddressUri = '$uri/api/save-user-address';
String getUserDataUri = '$uri/';

String orderUri = '$uri/api/order';
String placeOrderBuyNowUri = '$uri/api/place-order-buy-now';

//admin
String adminGetCategoryProductsUri = '$uri/admin/get-category-product';
String adminDeleteProductUri = '$uri/admin/delete-product';
String adminGetOrdersUri = '$uri/admin/get-orders';
String adminChangeOrderStatusUri = '$uri/admin/change-order-status';
String adminGetAnalyticsUri = '$uri/admin/analytics';
String adminAddProductsUri = '$uri/admin/add-product';
String adminAddFourImagesOfferUri = '$uri/admin/add-four-images-offer';
String adminGetFourImagesOfferUri = '$uri/api/get-four-images-offer';
String adminDeleteFourImagesOfferUri = '$uri/admin/delete-four-images-offer';
