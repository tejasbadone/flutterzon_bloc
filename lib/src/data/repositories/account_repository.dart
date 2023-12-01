import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/account_apis.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:http/http.dart' as http;

class AccountRepository {
  final AccountApis accountApis = AccountApis();

  Future<List<Order>> fetchMyOrders() async {
    try {
      List<Order> myOrderList = [];

      http.Response res = await accountApis.fetchMyOrders();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          myOrderList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return myOrderList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Order>> fetchsearchedOrders(String orderQuery) async {
    try {
      List<Order> searchedOrderList = [];
      http.Response res = await accountApis.searchOrders(orderQuery);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          searchedOrderList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }

        return searchedOrderList;
      } else {
        throw (Exception(jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<double> getProductRating(Product product) async {
    try {
      http.Response res = await accountApis.getProductRating(product);

      if (res.statusCode == 200) {
        double rating = jsonDecode(res.body).toDouble();
        return rating;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void rateProduct({required Product product, required double rating}) async {
    try {
      http.Response res =
          await accountApis.rateProduct(product: product, rating: rating);

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<double> getAverageRating(String productId) async {
    try {
      double averageRating = 0;

      http.Response res = await accountApis.getAverageRating(productId);

      if (res.statusCode == 200) {
        averageRating = jsonDecode(res.body).toDouble();

        return averageRating;
      } else {
        throw Exception(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addKeepShoppingFor({required Product product}) async {
    try {
      await accountApis.addKeepShoppingFor(product: product);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> getKeepShoppingFor() async {
    try {
      List<Product> productList = [];

      http.Response res = await accountApis.getKeepShoppingFor();

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
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> getWishList() async {
    try {
      List<Product> wishList = [];

      http.Response res = await accountApis.getWishList();

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

  void addToWishList({required Product product}) async {
    try {
      http.Response res = await accountApis.addToWishList(product: product);

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteFromWishList({required Product product}) async {
    try {
      bool isDeleted = false;

      http.Response res = await accountApis.deletFromWishList(product: product);

      if (res.statusCode == 200) {
        isDeleted = true;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
      return isDeleted;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> isWishListed({required Product product}) async {
    try {
      http.Response res = await accountApis.isWishListed(product: product);

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
