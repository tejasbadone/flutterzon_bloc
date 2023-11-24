import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/save_for_later/save_for_later_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_icon_button.dart';
import 'custom_text_button.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({super.key, required this.quantity, required this.product});

  final int quantity;
  final Product product;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  // final ProductDetailsServices productDetailsServices =
  //     ProductDetailsServices();
  // final HomeServices homeServices = HomeServices();

  // List<Product>? modalSheetProductList;

  // fetchCategoryProducts({required String category}) async {
  //   modalSheetProductList = await homeServices.fetchCategoryProducts(
  //       context: context, category: category);
  //   modalSheetProductList!.shuffle();
  //   if (context.mounted) {
  //     setState(() {});
  //   }
  // }

  // final CartServices cartServices = CartServices();

  // void increaseQuantity(Product product) {
  //   productDetailsServices.addToCart(context: context, product: product);
  // }

  // void decreaseQuantity(Product product) {
  //   cartServices.removeFromCart(context: context, product: product);
  // }

  // void deleteProduct(Product product) {
  //   cartServices.deleteFromCart(context: context, product: product);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchCategoryProducts(category: widget.category);
  // }

  @override
  Widget build(BuildContext context) {
    // final cartProduct = context.watch<UserProvider>().user.cart[widget.index];
    // final product = Product.fromMap(cartProduct['product']);
    // final quantity = widget.product.quantity;

    String price = formatPriceWithDecimal(widget.product.price);

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
                    widget.product.images[0],
                    // fit: BoxFit.fitHeight,
                    height: 140,
                    width: 140,
                  ),
                  Row(
                    children: [
                      Row(children: [
                        InkWell(
                          onTap: () => context
                              .read<CartBloc>()
                              .add(RemoveFromCart(product: widget.product)),
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
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.quantity.toString(),
                            style: TextStyle(
                                color: Constants.selectedNavBarColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        InkWell(
                          onTap: () => context
                              .read<CartBloc>()
                              .add(AddToCart(product: widget.product)),
                          child: const CustomIconbutton(
                            iconName: Icons.add,
                            isRight: true,
                          ),
                        ),
                      ])
                    ],
                  ),
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
                      widget.product.name,
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
                                  .add(DeleteFromCart(product: widget.product));
                              debugPrint('delete preesed!');
                              // deleteProduct(product);
                            }),
                        CustomTextButton(
                            buttonText: 'Save for later',
                            onPressed: () {
                              context
                                  .read<SaveForLaterBloc>()
                                  .add(SaveForLaterE(product: widget.product));
                              showSnackBar(context, 'Save for later!');
                            }),
                      ],
                    ),
                    CustomTextButton(
                        buttonText: 'See more like this',
                        onPressed: () {
                          // showModalBottomSheet(
                          //     constraints: const BoxConstraints(
                          //         minHeight: 350, maxHeight: 350),
                          //     shape: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(0)),
                          //     context: context,
                          //     builder: (context) {
                          //       return
                          // modalSheetProductList == null
                          //     ? const Center(
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     :
                          // Scaffold(
                          //     body: Container(
                          //       margin: const EdgeInsets.symmetric(
                          //           horizontal: 10, vertical: 16),
                          //       child: Column(
                          //         crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //         children: [
                          //           const Text(
                          //             'More items like this',
                          //             style: TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight:
                          //                     FontWeight.bold),
                          //           ),
                          //           const SizedBox(height: 10),
                          //           Expanded(
                          //             child: ListView.builder(
                          //                 scrollDirection:
                          //                     Axis.horizontal,
                          //                 itemCount:
                          //                     modalSheetProductList!
                          //                                 .length >
                          //                             20
                          //                         ? 20
                          //                         : modalSheetProductList!
                          //                             .length,
                          //                 itemBuilder:
                          //                     (context, index) {
                          //                   final product =
                          //                       modalSheetProductList![
                          //                           index];
                          //                   return AddToCartOffer(
                          //                       product: product);
                          //                 }),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   );
                          // });
                        }),
                  ],
                ),
              ),
            ]));
  }
}
