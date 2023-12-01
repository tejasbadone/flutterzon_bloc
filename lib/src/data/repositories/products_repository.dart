import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/products_api.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final ProductsApi productsApi = ProductsApi();

  Future<List<Product>> searchProducts(String searchQuery) async {
    List<Product> productList = [];

    try {
      http.Response res = await productsApi.searchProducts(searchQuery);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }

        return productList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getAverageRatingLength({required String productId}) async {
    try {
      http.Response res =
          await productsApi.getAverageRatingLength(productId: productId);

      if (res.statusCode == 200) {
        int getAverageRatingLength = jsonDecode(res.body);

        return getAverageRatingLength;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Product> getDealOfTheDay() async {
    try {
      Product product;
      http.Response res = await productsApi.getDealOfTheDay();

      if (res.statusCode == 200) {
        product = Product.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );

        return product;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
