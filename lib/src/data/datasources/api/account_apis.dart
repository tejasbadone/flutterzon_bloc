import 'package:flutter_amazon_clone_bloc/src/utils/constants/strings.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class AccountApis {
  final client = http.Client();

  Future<http.Response> fetchMyOrders() async {
    String token = await getToken();

    try {
      http.Response res =
          await client.get(Uri.parse(fetchMyOrdersUri), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });
      print(res.statusCode);

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
