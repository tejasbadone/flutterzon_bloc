import 'package:flutter/material.dart';

class SingleTopCategoryItem extends StatelessWidget {
  const SingleTopCategoryItem(
      {super.key,
      required this.image,
      required this.title,
      this.isBottomOffer = false});

  final String image;
  final String title;
  final bool isBottomOffer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isBottomOffer ? 0 : 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: isBottomOffer
                ? const TextStyle(fontSize: 11)
                : const TextStyle(),
          ),
        ],
      ),
    );
  }
}
