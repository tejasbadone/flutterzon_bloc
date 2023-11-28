import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/stars.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class YouMightAlsoLikeSingle extends StatelessWidget {
  const YouMightAlsoLikeSingle({
    super.key,
    required this.product,
    required this.averageRating,
  });

  final Product product;
  final double averageRating;

  @override
  Widget build(BuildContext context) {
    String? price;
    price = formatPrice(product.price);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              product.images[0],
              height: 130,
            ),
          ),
          Text(
            product.name,
            maxLines: 2,
            style: TextStyle(
                fontSize: 16,
                color: Constants.selectedNavBarColor,
                overflow: TextOverflow.ellipsis),
          ),
          Stars(
            rating: averageRating,
            size: 18,
          ),
          Text(
            '${product.rating!.length.toString()} reviews',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            '₹$price.00',
            maxLines: 2,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xffB12704),
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
