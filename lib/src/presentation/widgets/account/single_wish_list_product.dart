import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/wish_list/wish_list_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/stars.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SingleWishListProduct extends StatelessWidget {
  const SingleWishListProduct({
    super.key,
    required this.product,
    required this.deliveryDate,
    required this.averageRating,
  });

  final Product? product;
  final String? deliveryDate;
  final double averageRating;

  @override
  Widget build(BuildContext context) {
    const productTextStyle = TextStyle(
        fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal);

    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouteConstants.productDetailsScreenRoute.name,
            extra: {
              "product": product,
              "deliveryDate": deliveryDate,
            });
      },
      child: Container(
        height: 230,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 190,
              width: 160,
              decoration: const BoxDecoration(color: Color(0xffF7F7F7)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: CachedNetworkImage(
                  imageUrl: product!.images[0],
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
                      product!.name,
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
                        Text('(${product!.rating!.length})',
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
                          formatPrice(product!.price),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    RichText(
                      text: TextSpan(
                          text: 'Get it by ',
                          style: productTextStyle,
                          children: [
                            TextSpan(
                              text: deliveryDate,
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

                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                BlocProvider.of<WishListCubit>(context)
                                    .addToCartFromWishList(product: product!);
                              },
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Constants.yellowColor)),
                              child: const Text(
                                'Add to cart',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<WishListCubit>(context)
                                .removedFromWishListScreen(product: product!);
                          },
                          icon: const Icon(Icons.delete_outline),
                        )
                      ],
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
