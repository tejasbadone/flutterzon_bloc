import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/save_for_later/save_for_later_bloc.dart';
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

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // List<Product>? categoryProductList;
  // List<Product>? categoryProductList1;
  // List<Product>? categoryProductList2;

  // final HomeServices homeServices = HomeServices();
  // final CartServices cartServices = CartServices();

  // void navigateToAddressScreen(int sum) {
  //   Navigator.pushNamed(context, AddressScreen.routeName,
  //       arguments: sum.toString());
  // }

  // void deleteProduct(Product product) {
  //   cartServices.deleteFromCart(context: context, product: product);
  // }

  // void deleteFromLater(Product product) {
  //   cartServices.deleteFromLater(context: context, product: product);
  // }

  // void moveToCart(Product product) {
  //   cartServices.moveToCart(context: context, product: product);
  // }

  // void saveForLater(Product product) {
  //   cartServices.saveForLater(context: context, product: product);
  //   setState(() {});
  // }

  // fetchCategoryProducts({required String category}) async {
  //   List<Product>? list = await homeServices.fetchCategoryProducts(
  //       context: context, category: category);
  //   list.shuffle();
  //   return list;
  // }

  // fetchAllCartOffers({required providerCategory}) async {
  //   String randomCategory = getRandomFromMap(GlobalVariables.categoryImages);
  //   String randomCategory1 = getRandomFromMap(GlobalVariables.categoryImages);

  //   categoryProductList =
  //       await fetchCategoryProducts(category: providerCategory);
  //   categoryProductList1 =
  //       await fetchCategoryProducts(category: randomCategory);
  //   categoryProductList2 =
  //       await fetchCategoryProducts(category: randomCategory1);

  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   final category1 = Provider.of<CartOfferProvider>(context, listen: false);
  //   debugPrint(category1.category1);
  //   fetchAllCartOffers(providerCategory: category1.category1);
  // }

  @override
  Widget build(BuildContext context) {
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CartProductSuccessS) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12)
                            .copyWith(top: 20),
                        child:
                            // user.cart.isEmpty
                            //     ?
                            // SizedBox(
                            //     height: 200,
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         ClipOval(
                            //           child: Image.asset(
                            //             'assets/images/empty_cart.png',
                            //             height: 180,
                            //             width: 180,
                            //           ),
                            //         ),
                            //         const Text('Your Amazon Cart is empty')
                            //       ],
                            //     ),
                            //   ),
                            // :
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      color: Constants.selectedNavBarColor),
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
                                              color: Constants.greenColor,
                                              fontWeight: FontWeight.bold),
                                          children: [
                                        const TextSpan(
                                          text:
                                              'Select this option at checkout. ',
                                          style: TextStyle(
                                              height: 1.4,
                                              fontSize: 14,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text: 'Details ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Constants.selectedNavBarColor,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomElevatedButton(
                              buttonText:
                                  'Proceed to Buy (${state.cartProducts.length} items)',
                              onPressed: () {},
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
                                    // deleteProduct(product);
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    // saveForLater(product);
                                    // showSnackBar(context, 'Saved for later');
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
                                    // navigateToProductDetails(
                                    //     context: context,
                                    //     product: Product.fromMap(
                                    //         user.cart[index]['product']),
                                    //     deliveryDate: getDeliveryDate());
                                  },
                                  child: CartProduct(
                                    quantity: quantity,
                                    product: product,
                                  ),
                                ));
                          }),
                        ),
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
                      // user.saveForLater.isEmpty
                      //     ? const SizedBox()
                      // :

                      const SizedBox(height: 15),
                      // categoryProductList == null || categoryProductList!.isEmpty
                      //     ? const SizedBox()
                      //     :

                      // AddToCartWidget(
                      //     title: 'Frequently viewed with items in your cart',
                      //     isTitleLong: true,
                      //     list: categoryProductList),
                      // categoryProductList1 == null || categoryProductList1!.isEmpty
                      //     ? const SizedBox()
                      //     :

                      // AddToCartWidget(
                      //     title: 'Top picks for you',
                      //     isTitleLong: false,
                      //     list: categoryProductList1),

                      // categoryProductList2 == null || categoryProductList2!.isEmpty
                      //     ? const SizedBox()
                      //     :
                      //     AddToCartWidget(
                      //         title: 'Recommendations for you',
                      //         isTitleLong: false,
                      //         list: categoryProductList2),
                      // const SizedBox(height: 15),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
            BlocBuilder<SaveForLaterBloc, SaveForLaterState>(
              builder: (context, state) {
                if (state is SaveForLaterLoadingS) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SaveForLaterSuccessS) {
                  return Column(
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
                          'Saved for later (${state.saveForLaterProducts.length} items)',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: state.saveForLaterProducts.length,
                          itemBuilder: ((context, index) {
                            final product = state.saveForLaterProducts[index];
                            return Dismissible(
                              movementDuration:
                                  const Duration(milliseconds: 100),
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  // deleteFromLater(product);
                                } else if (direction ==
                                    DismissDirection.endToStart) {
                                  // moveToCart(product);
                                }
                              },
                              key: UniqueKey(),
                              background: const SwipeContainer(
                                  isDelete: true,
                                  secondaryBackgroundText: 'Move to cart'),
                              secondaryBackground: const SwipeContainer(
                                  isDelete: false,
                                  secondaryBackgroundText: 'Move to cart'),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, ProductDetailsScreen.routeName,
                                  //     arguments: arguments);
                                },
                                child: SaveForLaterSingle(
                                  product: product,
                                ),
                              ),
                            );
                          }))
                    ],
                  );
                }

                return const SizedBox();
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
      required this.list,
      required this.title,
      required this.isTitleLong});

  final List<Product>? list;
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
                  itemCount: list!.length > 20 ? 20 : list!.length,
                  itemBuilder: ((context, index) {
                    Product product = list![index];
                    return AddToCartOffer(product: product);
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
