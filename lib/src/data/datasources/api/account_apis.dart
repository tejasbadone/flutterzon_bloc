import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/strings.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class AccountApis {
  final client = http.Client();
  late final String token;

  AccountApis() {
    getTokenforMethod();
  }

  getTokenforMethod() async {
    token = await getToken();
  }

  Future<http.Response> fetchMyOrders() async {
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

  Future<http.Response> keepShoppingFor({required Product product}) async {
    try {
      http.Response res = await client.post(
        Uri.parse(keepShoppingForUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
