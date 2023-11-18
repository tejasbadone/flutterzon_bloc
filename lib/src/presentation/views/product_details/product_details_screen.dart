import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/product_rating/product_rating_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/product_details/user_rating/user_rating_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/stars.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/custom_carousel_slider.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/dots_indicator.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/product_details/customer_ratings.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/product_details/product_features.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/product_details/product_quality_icons.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/product_details/you_might_also_like.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String deliveryDate;
  final double averageRating;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.deliveryDate,
    required this.averageRating,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // final ProductDetailsServices productDetailsServices =
  //     ProductDetailsServices();

  // final AccountServices accountServices = AccountServices();

  final CarouselController controller = CarouselController();
  // final HomeServices homeServices = HomeServices();
  // List<Product>? categoryProductList;
  int currentIndex = 0;
  // bool isOrdered = false;

  // double averageRating = 0;
  // double userRating = -1;

  // String? price;
  // String? emi;
  // bool isFilled = false;

  // getCategoryProducts() async {
  //   categoryProductList = await homeServices.fetchCategoryProducts(
  //       context: context, category: widget.arguments['product'].category);
  //   categoryProductList!.shuffle();
  //   setState(() {});
  // }

  // addKeepShoppingForProduct() {
  //   accountServices.keepShoppingFor(
  //       context: context, product: widget.arguments['product']);
  //   setState(() {});
  // }

  // getProductRating() async {
  //   userRating = await productDetailsServices.getRating(
  //       context: context, product: widget.arguments['product']);
  //   if (context.mounted) {
  //     averageRating = await productDetailsServices.getAverageRating(
  //         context: context, product: widget.arguments['product']);
  //   }
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getProductRating();
  //   addKeepShoppingForProduct();
  //   getCategoryProducts();
  //   price = formatPrice(widget.arguments['product'].price);
  //   emi = getEmi(widget.arguments['product']);
  // }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context, listen: false).user;

    // Product product = widget.arguments['product'];
    // String deliveryDate = widget.arguments['deliveryDate'];

    // final cartCategoryOffer =
    //     Provider.of<CartOfferProvider>(context, listen: false);

    bool isFavourite = false;

    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    // String productId = widget.arguments['product'].id;

    // for (int i = 0; i < userProvider.user.wishList.length; i++) {
    //   if (productId == userProvider.user.wishList[i]['product']['_id']) {
    //     isFavourite = true;
    //     break;
    //   }
    // }

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const SizedBox(height: 10),
                    CustomCarouselSliderList(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        sliderImages: widget.product.images),
                    Positioned(
                        bottom: 10,
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: isFavourite == true
                                  ? InkWell(
                                      onTap: () {
                                        // accountServices.deleteFromWishList(
                                        //     context: context,
                                        //     product:
                                        //         widget.arguments['product']);
                                        // setState(() {
                                        //   isFavourite = false;
                                        // });
                                      },
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        // accountServices.addToWishList(
                                        //     context: context,
                                        //     product:
                                        //         widget.arguments['product']);
                                        // setState(() {
                                        //   isFavourite = true;
                                        // });
                                      },
                                      child: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                            )))
                  ],
                ),
                const SizedBox(height: 10),
                DotsIndicatorList(
                    controller: controller,
                    current: currentIndex,
                    sliderImages: widget.product.images),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Visit the Store',
                      style: TextStyle(color: Constants.selectedNavBarColor),
                    ),
                    Row(
                      children: [
                        Text(widget.averageRating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87)),
                        const SizedBox(width: 4),
                        Stars(rating: widget.averageRating),
                        const SizedBox(width: 6),
                        Text(
                          widget.product.rating!.length.toString(),
                          style: TextStyle(
                            color: Constants.selectedNavBarColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            const DividerWithSizedBox(),
            priceEmi(),
            const DividerWithSizedBox(
              sB1Height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Total: ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: '₹${formatPrice(widget.product.price)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: 'FREE delivery ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Constants.selectedNavBarColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.deliveryDate,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // user.address == ''
                    //     ? const SizedBox()
                    //     :
                    Expanded(
                      child: Text(
                        'Deliver to {} - {}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Constants.selectedNavBarColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'In stock',
                  style: TextStyle(color: Constants.greenColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomElevatedButton(
                    buttonText: 'Add to Cart',
                    onPressed: () {
                      // productDetailsServices.addToCart(
                      //     context: context,
                      //     product: widget.arguments['product']);
                      // showSnackBar(context, 'Added to cart!');
                      // setState(() {});
                      // cartCategoryOffer.setCategory1(
                      //     widget.arguments['product'].category.toString());
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomElevatedButton(
                  buttonText: 'Buy Now',
                  onPressed: () {
                    // Navigator.pushNamed(context, AddressScreenBuyNow.routeName,
                    //     arguments: product);
                  },
                  color: Constants.secondaryColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Secure transaction',
                      style: TextStyle(
                          color: Constants.selectedNavBarColor, fontSize: 15),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Gift-wrap available.',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    // if (isFavourite == true) {
                    //   showSnackBar(
                    //       context, 'This product is already in your wish list');
                    // } else {
                    //   accountServices.addToWishList(
                    //       context: context,
                    //       product: widget.arguments['product']);
                    //   setState(() {
                    //     isFavourite = true;
                    //   });
                    //   showSnackBar(context, 'Added to wish list!');
                    // }
                  },
                  child: Text(
                    'Add to Wish List',
                    style: TextStyle(
                        color: Constants.selectedNavBarColor, fontSize: 15),
                  ),
                ),
              ],
            ),
            const DividerWithSizedBox(),
            const ProductQualityIcons(),
            const DividerWithSizedBox(
              sB1Height: 4,
              sB2Height: 6,
            ),
            ProductFeatures(product: widget.product),
            const DividerWithSizedBox(),
            CustomerReviews(
                averageRating: widget.averageRating, product: widget.product),
            const DividerWithSizedBox(),

            // userRating == -1
            //     ? const SizedBox()
            //     :
            BlocConsumer<UserRatingCubit, UserRatingState>(
                listener: (context, state) {
              if (state is UserRatingErrorS) {
                showSnackBar(context, state.errorString);
              }
            }, builder: (context, state) {
              if (state is UpdateUserRatingInitialS) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is UserRatingSuccessS) {
                if (state.userRating == -1) {
                  print(state.userRating);
                  return const SizedBox();
                } else {
                  print(state.userRating);
                  return ratingFromUser(
                      context, state.userRating, widget.product);
                }
              } else {
                if (state is UpdateUserRatingSuccessS) {
                  return ratingFromUser(
                      context, state.userRating, widget.product);
                }
              }
              return const SizedBox();
            })

            // YouMightAlsoLike(
            //     categoryProductList: categoryProductList,
            //     deliveryDate: 'deliveryDate'),
          ]),
        ),
      ),
    );
  }

  Column ratingFromUser(
      BuildContext context, double userRating, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your star rating!',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        RatingBar.builder(
            itemSize: 28,
            initialRating: userRating,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Constants.secondaryColor,
                ),
            onRatingUpdate: (rating) {
              print('pressed!');
              BlocProvider.value(
                  value: UserRatingCubit(AccountRepository())
                    ..updateUserRating(userRating: rating, product: product));
            }),
        const DividerWithSizedBox(),
      ],
    );
  }

  Column priceEmi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            const SizedBox(
              width: 4,
            ),
            Text(
              formatPrice(widget.product.price),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'EMI ',
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            children: [
              TextSpan(
                text: 'from ₹${getEmi(widget.product)}. No Cost EMI available.',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' EMI options',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Constants.selectedNavBarColor,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Inclusive of all texes',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
