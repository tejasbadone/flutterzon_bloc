import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

import 'stars.dart';

class SingleListingProduct extends StatefulWidget {
  const SingleListingProduct({
    super.key,
    required this.product,
    required this.deliveryDate,
  });

  final Product? product;
  final String? deliveryDate;

  @override
  State<SingleListingProduct> createState() => _SingleListingProductState();
}

class _SingleListingProductState extends State<SingleListingProduct> {
  // final ProductDetailsServices productDetailsServices =
  //     ProductDetailsServices();

  double averageRating = 0;

  String? price;

  // getAverageRating() async {
  //   averageRating = await productDetailsServices.getAverageRating(
  //       context: context, product: widget.product!);
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    price = formatPrice(widget.product!.price);
    // getAverageRating();
  }

  @override
  Widget build(BuildContext context) {
    const productTextStyle = TextStyle(
        fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal);

    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        //     arguments: {
        //       'product': widget.product,
        //       'deliveryDate': widget.deliveryDate,
        //     });
      },
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 180,
              width: 160,
              decoration: const BoxDecoration(color: Color(0xffF7F7F7)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: CachedNetworkImage(
                  imageUrl: widget.product!.images[0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 4, top: 4, bottom: 4),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.product!.name,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Constants.selectedNavBarColor),
                        ),
                        Stars(
                          rating: averageRating,
                          size: 20,
                        ),
                        Text('(${widget.product!.rating!.length})',
                            style: productTextStyle.copyWith(fontSize: 14)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '₹',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          price!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                          text: 'Get it by ',
                          style: productTextStyle,
                          children: [
                            TextSpan(
                              text: widget.deliveryDate,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff56595A)),
                            )
                          ]),
                    ),
                    // const SizedBox(height: 4),
                    const Text(
                      'FREE Delivery by Amazon',
                      style: productTextStyle,
                    ),
                    // const SizedBox(height: 4),
                    const Text(
                      '7 days Replacement',
                      style: productTextStyle,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
