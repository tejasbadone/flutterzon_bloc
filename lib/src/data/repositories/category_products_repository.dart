import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/category_products_api.dart';

class CategoryProductsRepository {
  final CategoryProductsApi categoryProductsApi = CategoryProductsApi();

  Future<List<Product>> fetchCategoryProducts(String category) async {
    List<Product> productList = [];

    try {
      http.Response res =
          await categoryProductsApi.fetchCategoryProducts(category);

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
