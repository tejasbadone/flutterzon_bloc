import 'package:flutter_dotenv/flutter_dotenv.dart';

final secureUri = dotenv.env['URI'];
String uri = secureUri!;

String signUpUrl = '$uri/api/signup';
String signInUrl = '$uri/api/signin';
String fetchCategoryProductsUri = '$uri/api/products?category=';
String searchProductsUri = '$uri/api/products/search';
String fetchMyOrdersUri = '$uri/api/orders/me';
