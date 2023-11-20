import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
    required this.iconName,
    required this.title,
  });
  final String iconName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/cart_screen_icons/$iconName',
          height: 55,
          width: 55,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Constants.selectedNavBarColor),
        )
      ],
    );
  }
}
