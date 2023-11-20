import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    int sum = 0;

    // userProvider.cart
    //     .map((e) => sum += e['quantity'] * e['product']['price'] as int)
    //     .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'SubTotal ',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black87),
        ),
        const Text(
          '₹',
          style: TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        Text(
          formatPriceWithDecimal(sum),
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}
