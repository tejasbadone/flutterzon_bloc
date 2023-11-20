import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/stars.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class AddToCartOffer extends StatefulWidget {
  const AddToCartOffer({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<AddToCartOffer> createState() => _AddToCartOfferState();
}

// String? price;

class _AddToCartOfferState extends State<AddToCartOffer> {
  // @override
  // void initState() {
  //   super.initState();
  //   price =
  // }

  @override
  Widget build(BuildContext context) {
    //   double totalRating = 0;
    //   for (int i = 0; i < widget.product.rating!.length; i++) {
    //     totalRating += widget.product.rating![i].rating;
    //   }

    //   double averageRating = 0;
    //   if (totalRating != 0) {
    //     averageRating = totalRating / widget.product.rating!.length;
    //   }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // navigateToProductDetails(
                //     context: context,
                //     product: widget.product,
                //     deliveryDate: getDeliveryDate());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      widget.product.images[0],
                      height: 130,
                      width: 130,
                    ),
                  ),
                  Text(
                    widget.product.name,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Constants.selectedNavBarColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Row(
                    children: [
                      Stars(
                        rating: 4,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.product.rating!.length.toString(),
                        style: TextStyle(
                          color: Constants.selectedNavBarColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹price.00',
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffB12704),
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   addToCart(context, widget.product);
                // });
              },
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  minimumSize: MaterialStatePropertyAll(Size(100, 35)),
                  maximumSize: MaterialStatePropertyAll(Size(100, 35)),
                  fixedSize: MaterialStatePropertyAll(Size(100, 35)),
                  backgroundColor:
                      MaterialStatePropertyAll(Constants.yellowColor)),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
