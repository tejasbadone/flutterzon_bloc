import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

import 'custom_text_button.dart';

class SaveForLaterSingle extends StatefulWidget {
  const SaveForLaterSingle({super.key, required this.product});

  final Product product;

  @override
  State<SaveForLaterSingle> createState() => _SaveForLaterSingleState();
}

class _SaveForLaterSingleState extends State<SaveForLaterSingle> {
  // final ProductDetailsServices productDetailsServices =
  //     ProductDetailsServices();
  // final HomeServices homeServices = HomeServices();

  List<Product>? modalSheetProductList;

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
  //   fetchCategoryProducts(category: widget.product.category);
  // }

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;

    String price = formatPriceWithDecimal(widget.product.price);

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
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomTextButton(
                      buttonText: 'Delete',
                      onPressed: () {
                        // cartServices.deleteFromLater(
                        //     context: context, product: product);
                      }),
                ),
                Expanded(
                  child: CustomTextButton(
                      buttonText: 'Compare',
                      onPressed: () {
                        showModalBottomSheet(
                            constraints: const BoxConstraints(
                                minHeight: 350, maxHeight: 350),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            context: context,
                            builder: (context) {
                              return modalSheetProductList == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MoreLikeThisBottomSheet(
                                      modalSheetProductList:
                                          modalSheetProductList);
                            });
                      }),
                ),
                Expanded(
                  child: CustomTextButton(
                      buttonText: 'Move to cart',
                      onPressed: () {
                        // cartServices.moveToCart(
                        //     context: context, product: product);
                      }),
                ),
              ],
            ),
          ],
        ));
  }
}

class MoreLikeThisBottomSheet extends StatelessWidget {
  const MoreLikeThisBottomSheet({
    super.key,
    required this.modalSheetProductList,
  });

  final List<Product>? modalSheetProductList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'More items like this',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Expanded(
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: modalSheetProductList!.length > 20
            //           ? 20
            //           : modalSheetProductList!.length,
            //       itemBuilder: (context, index) {
            //         final product = modalSheetProductList![index];
            //         return AddToCartOffer(product: product);
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}
