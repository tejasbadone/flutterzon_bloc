import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/user_apis.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final UserApi userApi = UserApi();

  Future<List<Product>> addToCartFromWishList(
      {required Product product}) async {
    try {
      List<Product> wishList = [];

      http.Response res = await userApi.addToCartFromWishList(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          wishList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return wishList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
