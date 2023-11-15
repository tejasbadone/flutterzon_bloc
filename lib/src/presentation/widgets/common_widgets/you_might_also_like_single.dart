import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/stars.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class YouMightAlsoLikeSingle extends StatefulWidget {
  const YouMightAlsoLikeSingle({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<YouMightAlsoLikeSingle> createState() => _YouMightAlsoLikeSingleState();
}

String? price;

class _YouMightAlsoLikeSingleState extends State<YouMightAlsoLikeSingle> {
  @override
  void initState() {
    super.initState();
    price = formatPrice(widget.product.price);
  }

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
    }

    double averageRating = 0;
    if (totalRating != 0) {
      averageRating = totalRating / widget.product.rating!.length;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              widget.product.images[0],
              height: 130,
            ),
          ),
          Text(
            widget.product.name,
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
            '${widget.product.rating!.length.toString()} reviews',
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
