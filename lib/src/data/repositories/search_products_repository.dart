import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/search_products.api.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:http/http.dart' as http;

class SearchProductsRepository {
  final SearchProductsApi searchProductsApi = SearchProductsApi();

  Future<List<Product>> searchProducts(String searchQuery) async {
    List<Product> productList = [];

    try {
      http.Response res = await searchProductsApi.searchProducts(searchQuery);

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
}
