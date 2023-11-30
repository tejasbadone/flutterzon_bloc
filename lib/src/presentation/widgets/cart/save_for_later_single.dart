import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/add_to_card_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_text_button.dart';

class SaveForLaterSingle extends StatelessWidget {
  const SaveForLaterSingle({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    String price = formatPriceWithDecimal(product.price);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: const Color(0xffF8F9FB),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.images[0],
                    // fit: BoxFit.fitHeight,
                    height: 140,
                    width: 140,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 6,
                    child: Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          children: [
                            const Text(
                              '₹',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              price,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Text(
                          'Eligible for FREE Shipping',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const Text(
                          'In stock',
                          style: TextStyle(
                            fontSize: 14,
                            color: Constants.greenColor,
                          ),
                        ),
                        Text(
                          '7 days Replacement',
                          style: TextStyle(
                            fontSize: 14,
                            color: Constants.selectedNavBarColor,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ]),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomTextButton(
                      buttonText: 'Delete',
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(DeleteFromLaterE(product: product));
                      }),
                ),
                Expanded(
                  child: CustomTextButton(
                      buttonText: 'Compare',
                      onPressed: () {
                        context.read<FetchCategoryProductsBloc>().add(
                            CategoryPressedEvent(category: product.category));

                        showModalBottomSheet(
                                constraints: const BoxConstraints(
                                    minHeight: 350, maxHeight: 350),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    body: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'More items like this',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          BlocBuilder<FetchCategoryProductsBloc,
                                              FetchCategoryProductsState>(
                                            builder: (context, state) {
                                              if (state
                                                  is FetchCategoryProductsSuccessS) {
                                                return Expanded(
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: state
                                                                  .productList
                                                                  .length >
                                                              20
                                                          ? 20
                                                          : state.productList
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final product = state
                                                            .productList[index];

                                                        final averageRating =
                                                            state.averageRatingList[
                                                                index];
                                                        return AddToCartOffer(
                                                          product: product,
                                                          averageRating:
                                                              averageRating,
                                                        );
                                                      }),
                                                );
                                              }

                                              return const SizedBox(
                                                height: 250,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            .whenComplete(() =>
                                context.read<CartBloc>().add(GetCartPressed()));
                      }),
                ),
                Expanded(
                  child: CustomTextButton(
                      buttonText: 'Move to cart',
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(MoveToCartE(product: product));
                      }),
                ),
              ],
            ),
          ],
        ));
  }
}
