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
String rateProductUri = '$uri/api/rate-product';
String keepShoppingForUri = '$uri/api/keep-shopping-for';
