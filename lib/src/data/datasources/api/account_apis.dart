import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/strings.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class AccountApis {
  final client = http.Client();

  Future<http.Response> fetchMyOrders() async {
    final String token = await getToken();
    try {
      http.Response res =
          await client.get(Uri.parse(fetchMyOrdersUri), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> searchOrders(String orderQuery) async {
    final String token = await getToken();
    try {
      http.Response res =
          await client.get(Uri.parse('$searchOrdersUri/$orderQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getProductRating(Product product) async {
    final String token = await getToken();
    try {
      http.Response res = await client
          .get(Uri.parse('$getProductRatingUri/${product.id}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> rateProduct(
      {required Product product, required double rating}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(rateProductUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            'id': product.id,
            'rating': rating,
          },
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getAverageRating(String productId) async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse('$getAverageRatingUri/$productId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addKeepShoppingFor({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse('$addKeepShoppingForUri/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getKeepShoppingFor() async {
    final String token = await getToken();
    try {
      http.Response res = await http.get(
        Uri.parse(getKeepShoppingForUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getWishList() async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(getWishListUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addToWishList({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(Uri.parse(addToWishListUri),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode({
            "id": product.id,
          }));

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> deletFromWishList({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.delete(
        Uri.parse('$removeFromWishListUri/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> isWishListed({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse('$isWishListedUri/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
