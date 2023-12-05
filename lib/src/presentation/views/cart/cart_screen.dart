import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit1/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit2/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit3/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/add_to_card_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/amazon_pay_bannar_ad.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/cart_icon.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/cart_product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/save_for_later_single.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/cart/swipe_container.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  getCartOffers(context) async {
    List<String> categories =
        await BlocProvider.of<CartOffersCubit1>(context).setOfferCategories();
    BlocProvider.of<CartOffersCubit1>(context)
        .cartOffers1(category: categories[0]);
    BlocProvider.of<CartOffersCubit2>(context)
        .cartOffers2(category: categories[1]);
    BlocProvider.of<CartOffersCubit3>(context)
        .cartOffers3(category: categories[2]);
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(GetCartPressed());
    getCartOffers(context);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartProductErrorS) {
                  return showSnackBar(context, state.errorString);
                }
              },
              builder: (context, state) {
                if (state is CartLoadingS) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height - 180,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is CartProductSuccessS) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12)
                                .copyWith(top: 20),
                            child: state.cartProducts.isEmpty
                                ? SizedBox(
                                    height: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/images/empty_cart.png',
                                            height: 180,
                                            width: 180,
                                          ),
                                        ),
                                        const Text('Your Amazon Cart is empty')
                                      ],
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'SubTotal ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87),
                                          ),
                                          const Text(
                                            '₹',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            formatPriceWithDecimal(state.total),
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'EMI Available ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            'Details',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Constants
                                                    .selectedNavBarColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Constants.greenColor,
                                            size: 25,
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        'Your order is eligible for FREE Delivery. ',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Constants
                                                            .greenColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                  const TextSpan(
                                                    text:
                                                        'Select this option at checkout. ',
                                                    style: TextStyle(
                                                        height: 1.4,
                                                        fontSize: 14,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  TextSpan(
                                                    text: 'Details ',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Constants
                                                            .selectedNavBarColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ])),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      CustomElevatedButton(
                                        buttonText: state.cartProducts.length ==
                                                1
                                            ? 'Proceed to Buy (${state.cartProducts.length} item)'
                                            : 'Proceed to Buy (${state.cartProducts.length} items)',
                                        onPressed: () {
                                          context.pushNamed(
                                              AppRouteConstants
                                                  .paymentScreenRoute.name,
                                              extra: state.total);
                                        },
                                        isRectangle: true,
                                      ),
                                      const DividerWithSizedBox(
                                        thickness: 0.5,
                                        sB1Height: 20,
                                      )
                                    ],
                                  ),
                          ),
                          Visibility(
                            visible: state.cartProducts.isNotEmpty,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: state.cartProducts.length,
                              itemBuilder: ((context, index) {
                                final product = state.cartProducts[index];
                                final quantity = state.productsQuantity[index];

                                return Dismissible(
                                    movementDuration:
                                        const Duration(milliseconds: 100),
                                    onDismissed: (DismissDirection direction) {
                                      if (direction ==
                                          DismissDirection.startToEnd) {
                                        context.read<CartBloc>().add(
                                            DeleteFromCart(product: product));
                                        showSnackBar(context, 'Deleted!');
                                        // deleteProduct(product);
                                      } else if (direction ==
                                          DismissDirection.endToStart) {
                                        context.read<CartBloc>().add(
                                            SaveForLaterE(product: product));
                                        showSnackBar(
                                            context, 'Saved for later!');
                                      }
                                    },
                                    background: const SwipeContainer(
                                      isDelete: true,
                                      secondaryBackgroundText: 'Save for later',
                                    ),
                                    secondaryBackground: const SwipeContainer(
                                      isDelete: false,
                                      secondaryBackgroundText: 'Save for later',
                                    ),
                                    key: UniqueKey(),
                                    child: InkWell(
                                      onTap: () {
                                        context.pushNamed(
                                            AppRouteConstants
                                                .productDetailsScreenRoute.name,
                                            extra: {
                                              "product": product,
                                              "deliveryDate": getDeliveryDate(),
                                            });
                                      },
                                      child: CartProduct(
                                        quantity: quantity,
                                        product: product,
                                      ),
                                    ));
                              }),
                            ),
                          ),
                        ],
                      ),
                      const DividerWithSizedBox(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CartIcon(
                            iconName: 'secure_payment.png',
                            title: 'Secure Payment',
                          ),
                          CartIcon(
                            iconName: 'delivered_alt.png',
                            title: 'Amazon Delivered',
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const AmazonPayBannarAd(),
                      const SizedBox(height: 15),
                      state.saveForLaterProducts.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(4),
                                  color: const Color(0xffE9EDEE),
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    state.saveForLaterProducts.length == 1
                                        ? 'Saved for later (${state.saveForLaterProducts.length} item)'
                                        : 'Saved for later (${state.saveForLaterProducts.length} items)',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        state.saveForLaterProducts.length,
                                    itemBuilder: ((context, index) {
                                      final product =
                                          state.saveForLaterProducts[index];
                                      return Dismissible(
                                        movementDuration:
                                            const Duration(milliseconds: 100),
                                        onDismissed:
                                            (DismissDirection direction) {
                                          if (direction ==
                                              DismissDirection.startToEnd) {
                                            context.read<CartBloc>().add(
                                                DeleteFromLaterE(
                                                    product: product));
                                          } else if (direction ==
                                              DismissDirection.endToStart) {
                                            context.read<CartBloc>().add(
                                                MoveToCartE(product: product));
                                          }
                                        },
                                        key: UniqueKey(),
                                        background: const SwipeContainer(
                                            isDelete: true,
                                            secondaryBackgroundText:
                                                'Move to cart'),
                                        secondaryBackground:
                                            const SwipeContainer(
                                                isDelete: false,
                                                secondaryBackgroundText:
                                                    'Move to cart'),
                                        child: InkWell(
                                          onTap: () {
                                            context.pushNamed(
                                                AppRouteConstants
                                                    .productDetailsScreenRoute
                                                    .name,
                                                extra: {
                                                  "product": product,
                                                  "deliveryDate":
                                                      getDeliveryDate(),
                                                });
                                          },
                                          child: SaveForLaterSingle(
                                            product: product,
                                          ),
                                        ),
                                      );
                                    }))
                              ],
                            ),
                      const SizedBox(height: 15),
                      BlocBuilder<CartOffersCubit1, CartOffersState1>(
                          builder: (context, state) {
                        if (state is CartOffersSuccessS1) {
                          return state.productList.isEmpty
                              ? const SizedBox()
                              : AddToCartWidget(
                                  title: 'Top picks for you',
                                  isTitleLong: false,
                                  productList: state.productList,
                                  averageRating: state.averageRatingList,
                                );
                        }
                        return const SizedBox();
                      }),
                      BlocBuilder<CartOffersCubit2, CartOffersState2>(
                          builder: (context, state) {
                        if (state is CartOffersSuccessS2) {
                          return state.productList.isEmpty
                              ? const SizedBox()
                              : AddToCartWidget(
                                  title:
                                      'Frequently viewed with items in your cart',
                                  isTitleLong: true,
                                  productList: state.productList,
                                  averageRating: state.averageRatingList,
                                );
                        }
                        return const SizedBox();
                      }),
                      BlocBuilder<CartOffersCubit3, CartOffersState3>(
                          builder: (context, state) {
                        if (state is CartOffersSuccessS3) {
                          return state.productList.isEmpty
                              ? const SizedBox()
                              : AddToCartWidget(
                                  title: 'Recommendations for you',
                                  isTitleLong: false,
                                  productList: state.productList,
                                  averageRating: state.averageRatingList,
                                );
                        }
                        return const SizedBox();
                      }),
                    ],
                  );
                }

                return SizedBox(
                  height: MediaQuery.sizeOf(context).height - 180,
                  width: MediaQuery.sizeOf(context).width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget(
      {super.key,
      required this.productList,
      required this.averageRating,
      required this.title,
      required this.isTitleLong});

  final List<Product>? productList;
  final List<double>? averageRating;
  final String title;
  final bool isTitleLong;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 18),
      width: MediaQuery.sizeOf(context).height,
      color: const Color(0xffE9EDEE),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(top: 12),
        color: Colors.white,
        height: isTitleLong ? 370 : 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 290,
              child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      productList!.length > 20 ? 20 : productList!.length,
                  itemBuilder: ((context, index) {
                    Product product = productList![index];

                    return AddToCartOffer(
                      product: product,
                      averageRating: averageRating![index],
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
