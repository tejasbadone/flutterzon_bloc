import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  final double size;
  const Stars({super.key, required this.rating, this.size = 15});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        direction: Axis.horizontal,
        itemCount: 5,
        rating: rating,
        itemSize: size,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Constants.secondaryColor,
            ));
  }
}
