import 'dart:convert';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/strings.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class UserApi {
  final client = http.Client();

  Future<http.Response> getUserDataInitial(var token) async {
    try {
      http.Response res = await client.get(
        Uri.parse(getUserDataUri),
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

  Future<http.Response> getUserData() async {
    final token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(getUserDataUri),
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

  Future<http.Response> addToCartFromWishList(
      {required Product product}) async {
    final token = await getToken();

    try {
      http.Response res = await client.post(Uri.parse(addToCartFromWishListUri),
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

  Future<http.Response> getCart() async {
    final token = await getToken();

    try {
      http.Response res = await client.get(
        Uri.parse(getCartUri),
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

  Future<http.Response> addToCart({required Product product}) async {
    final token = await getToken();

    try {
      http.Response res = await client.post(Uri.parse(addToCartUri),
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

  Future<http.Response> removeFromCart({required Product product}) async {
    final token = await getToken();
    try {
      http.Response res = await client.delete(
        Uri.parse('$removeFromCartUri/${product.id}'),
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

  Future<http.Response> deleteFromCart({required Product product}) async {
    final token = await getToken();
    try {
      http.Response res = await client.delete(
        Uri.parse('$deleteFromCartUri/${product.id}'),
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

  Future<http.Response> saveForLater({required Product product}) async {
    final token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(saveForLaterUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode({
          "id": product.id,
        }),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getSaveForLater() async {
    final token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(getSaveForLaterUri),
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

  Future<http.Response> deleteFromLater({required Product product}) async {
    final token = await getToken();
    try {
      http.Response res = await client.delete(
        Uri.parse('$deleteFromLaterUri/${product.id}'),
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

  Future<http.Response> moveToCart({required Product product}) async {
    final token = await getToken();

    try {
      http.Response res = await client.post(
        Uri.parse(moveToCartUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            "id": product.id,
          },
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> saveUserAddress({required String address}) async {
    final token = await getToken();
    try {
      http.Response res = await client.post(Uri.parse(saveUserAddressUri),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode({
            "address": address,
          }));
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> placeOrder(
      {required double totalPrice, required String address}) async {
    final token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(orderUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            "totalPrice": totalPrice,
            "address": address,
          },
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> placeOrderBuyNow(
      {required Product product, required String address}) async {
    final token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(placeOrderBuyNowUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            'id': product.id,
            'totalPrice': product.price,
            'address': address,
          },
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
