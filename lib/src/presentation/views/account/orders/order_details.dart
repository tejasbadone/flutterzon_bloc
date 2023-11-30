import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/product_rating/product_rating_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/widgets/shipment_details.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/widgets/standard_delivery_container.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/widgets/you_might_also_like_block.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    context
        .read<FetchCategoryProductsBloc>()
        .add(CategoryPressedEvent(category: order.products[0].category));

    User user = context.read<UserCubit>().currentUser!;

    int totalQuantity = order.products.length;
    final BoxDecoration containerDecoration = BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8));

    const TextStyle textStyle = TextStyle(
        color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15);

    const TextStyle headingTextSyle = TextStyle(
        color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View order details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  height: 90,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: containerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Order date        ${formatDate(order.orderedAt)}',
                        style: textStyle,
                      ),
                      Text('Order #              ${order.id}',
                          style: textStyle),
                      Text(
                          'Order total        ₹${formatPrice(order.totalPrice)}',
                          style: textStyle),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Shipment details', style: headingTextSyle),
            const SizedBox(
              height: 6,
            ),

            //Shipment Details block
            Column(
              children: [
                StandardDeliveryContainer(
                    containerDecoration: containerDecoration,
                    textSyle: textStyle),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: containerDecoration.copyWith(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShipmentStatus(
                          currentStep: order.status, textStyle: textStyle),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: order.products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        context.pushNamed(
                                            AppRouteConstants
                                                .productDetailsScreenRoute.name,
                                            extra: {
                                              'product': order.products[index],
                                              'deliveryDate': getDeliveryDate(),
                                            });
                                      },
                                      child: Row(
                                        children: [
                                          Image.network(
                                            order.products[index].images[0],
                                            height: 110,
                                            width: 100,
                                            fit: BoxFit.contain,
                                            // width: 120,
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  order.products[index].name,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                    'Qty. ${order.quantity[index]}'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            '₹${formatPrice(order.products[index].price)}',
                                            style: textStyle.copyWith(
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Your rating',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                      BlocConsumer<ProductRatingBloc,
                                          ProductRatingState>(
                                        listener: (context, state) {
                                          if (state is GetProductRatingErrorS) {
                                            showSnackBar(
                                                context, state.errorString);
                                          }
                                          if (state is RateProductErrorS) {
                                            showSnackBar(
                                                context, state.errorString);
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state
                                              is GetProductRatingInitialS) {
                                            return RatingBarWidget(
                                              rating: state.initialRating,
                                              product: order.products[index],
                                              order: order,
                                            );
                                          }

                                          if (state
                                              is GetProductRatingSuccessS) {
                                            return RatingBarWidget(
                                              rating: state.ratingsList[index],
                                              product: order.products[index],
                                              order: order,
                                            );
                                          }

                                          if (state is RateProductInitialS) {
                                            return RatingBarWidget(
                                              rating: state.ratingsList[index],
                                              product: order.products[index],
                                              order: order,
                                            );
                                          }

                                          if (state is RateProductSuccessS) {
                                            return RatingBarWidget(
                                              rating: state
                                                  .updatedRatingsList[index],
                                              product: order.products[index],
                                              order: order,
                                            );
                                          }

                                          return const SizedBox(
                                            child: Center(
                                              child: LinearProgressIndicator(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Track shipment
            Column(
              children: [
                ListTile(
                  onTap: () {
                    context.pushNamed(
                        AppRouteConstants.trackingDetailsScreenRoute.name,
                        extra: {
                          "order": order,
                          "user": user,
                        });
                  },
                  title: Text(
                    user.type == 'user'
                        ? 'Track shipment'
                        : 'Update shipment (admin)',
                    style: user.type == 'user'
                        ? textStyle
                        : textStyle.copyWith(color: Constants.greenColor),
                  ),
                  style: ListTileStyle.list,
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: user.type == 'user'
                        ? Colors.black87
                        : Constants.greenColor,
                  ),
                ),
              ],
            ),
            const DividerWithSizedBox(
              thickness: 1,
              sB1Height: 0,
              sB2Height: 5,
            ),

            // Payment Infomrmation block
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment information',
                  style: headingTextSyle,
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    alignment: Alignment.centerLeft,
                    decoration: containerDecoration.copyWith(
                      border: const Border(
                          left: BorderSide(color: Colors.black12, width: 1),
                          right: BorderSide(color: Colors.black12, width: 1),
                          top: BorderSide(color: Colors.black12, width: 1),
                          bottom: BorderSide(color: Colors.black12, width: 0)),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method',
                          style: textStyle.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Google Pay',
                          style: textStyle.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: containerDecoration.copyWith(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Billing Address',
                        style: textStyle.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        order.address,
                        style: textStyle.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Shipping Address', style: headingTextSyle),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: containerDecoration,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizeFirstLetter(string: user.name),
                          style: textStyle.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          order.address,
                          style: textStyle.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            //Order summary block
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order Summary', style: headingTextSyle),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: containerDecoration,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderSummaryRow(
                          firstText: 'Items:',
                          secondText: totalQuantity.toString(),
                          textSyle: textStyle,
                        ),
                        const OrderSummaryRow(
                          firstText: 'Postage & Packing:',
                          secondText: '₹0',
                          textSyle: textStyle,
                        ),
                        OrderSummaryRow(
                          firstText: 'Sub total:',
                          secondText:
                              '₹${formatPriceWithDecimal(order.totalPrice)}',
                          textSyle: textStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Order Total:',
                              style: headingTextSyle,
                            ),
                            Text(
                              '₹${formatPriceWithDecimal(order.totalPrice)}',
                              style: headingTextSyle.copyWith(
                                color: Constants.redColor,
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            user.type == 'admin'
                ? const SizedBox()
                : YouMightAlsoLikeBlock(
                    productName: order.products[0].name.length >= 30
                        ? order.products[0].name.substring(0, 30)
                        : order.products[0].name
                            .substring(0, order.products[0].name.length))
          ],
        ),
      )),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    required this.rating,
    required this.product,
    required this.order,
  });

  final double rating;
  final Product product;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 28,
      initialRating: rating == -1 ? 0 : rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Constants.secondaryColor,
      ),
      onRatingUpdate: (rating) {
        BlocProvider.value(
          value: ProductRatingBloc(AccountRepository())
            ..add(
              RateProductPressedEvent(
                  order: order, product: product, rating: rating),
            ),
        );
      },
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  const OrderSummaryRow({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.textSyle,
  });

  final TextStyle textSyle;
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: textSyle.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          secondText,
          style: textSyle.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
