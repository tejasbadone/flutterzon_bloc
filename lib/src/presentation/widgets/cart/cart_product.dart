import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/add_to_card_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_icon_button.dart';
import 'custom_text_button.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key, required this.quantity, required this.product});

  final int quantity;
  final Product product;

  @override
  Widget build(BuildContext context) {
    String price = formatPriceWithDecimal(product.price);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: const Color(0xffF8F9FB),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 30,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Image.network(
                    product.images[0],
                    // fit: BoxFit.fitHeight,
                    height: 140,
                    width: 140,
                  ),
                  Row(children: [
                    InkWell(
                      onTap: () => context
                          .read<CartBloc>()
                          .add(RemoveFromCart(product: product)),
                      child: const CustomIconbutton(
                          iconName: Icons.remove, isRight: false),
                    ),
                    Container(
                      height: 30,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: const Border(
                            top: BorderSide(color: Colors.grey, width: 0.5),
                            bottom: BorderSide(color: Colors.grey, width: 0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                            color: Constants.selectedNavBarColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    InkWell(
                      onTap: () => context
                          .read<CartBloc>()
                          .add(AddToCart(product: product)),
                      child: const CustomIconbutton(
                        iconName: Icons.add,
                        isRight: true,
                      ),
                    ),
                  ])
                ],
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        CustomTextButton(
                            buttonText: 'Delete',
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(DeleteFromCart(product: product));
                              debugPrint('delete preesed!');
                              // deleteProduct(product);
                            }),
                        CustomTextButton(
                            buttonText: 'Save for later',
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(SaveForLaterE(product: product));
                              showSnackBar(context, 'Save for later!');
                            }),
                      ],
                    ),
                    CustomTextButton(
                        buttonText: 'See more like this',
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
                                            BlocBuilder<
                                                FetchCategoryProductsBloc,
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
                                                          final product =
                                                              state.productList[
                                                                  index];

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
                              .whenComplete(() => context
                                  .read<CartBloc>()
                                  .add(GetCartPressed()));
                        }),
                  ],
                ),
              ),
            ]));
  }
}
