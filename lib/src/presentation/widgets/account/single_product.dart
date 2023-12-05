import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Container(
          padding: const EdgeInsets.all(8),
          child: CachedNetworkImage(
            imageUrl: image,
            width: 100,
          )),
    );
  }
}
