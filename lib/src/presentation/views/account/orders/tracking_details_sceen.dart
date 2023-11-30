import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/widgets/tracking_details_bottom_sheet.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/widgets/you_might_also_like_block.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:go_router/go_router.dart';

class TrackingDetailsScreen extends StatelessWidget {
  final Order order;
  final User user;
  const TrackingDetailsScreen(
      {super.key, required this.order, required this.user});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Constants.selectedNavBarColor);

    const TextStyle subtextStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black87);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user.type == 'user'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getStatus(order.status),
                                    style: textStyle,
                                  ),
                                  Text(
                                    getSubStatus(order.status),
                                    style: subtextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () => context.pushNamed(
                                    AppRouteConstants
                                        .orderDetailsScreenRoute.name,
                                    extra: order),
                                child: CachedNetworkImage(
                                  imageUrl: order.products[0].images[0],
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const DividerWithSizedBox(
                          thickness: 0.5,
                          sB1Height: 8,
                        ),
                        UserAddressBlock(
                          order: order,
                          user: user,
                          subtextStyle: subtextStyle,
                        ),
                        const DividerWithSizedBox(
                          thickness: 4,
                          sB1Height: 20,
                          sB2Height: 20,
                        ),
                        const Text(
                          'Delivery by Amazon',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                        Text(
                          ' Order ID: ${order.id}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ],
                    )
                  : TrackingDetailsBottomSheet(
                      order: order,
                      user: user,
                    ),
              const DividerWithSizedBox(
                thickness: 4,
                sB1Height: 20,
                sB2Height: 15,
              ),
              const Text(
                'Order Info',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 0.5,
                color: Color(0xffD5D9DA),
              ),
              ListTile(
                onTap: () => context.pushNamed(
                    AppRouteConstants.orderDetailsScreenRoute.name,
                    extra: order),
                title: Text('View order details',
                    style: subtextStyle.copyWith(fontSize: 15)),
                style: ListTileStyle.list,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: user.type == 'user'
                      ? Colors.black87
                      : Constants.greenColor,
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: Color(0xffD5D9DA),
              ),
              const DividerWithSizedBox(
                thickness: 4,
                sB1Height: 20,
                sB2Height: 15,
              ),
              user.type == 'user'
                  ? YouMightAlsoLikeBlock(
                      productName: order.products[0].name.length >= 30
                          ? order.products[0].name.substring(0, 30)
                          : order.products[0].name.substring(
                              0,
                              order.products[0].name.length,
                            ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class UserAddressBlock extends StatelessWidget {
  const UserAddressBlock({
    super.key,
    required this.user,
    required this.subtextStyle,
    required this.order,
  });

  final Order order;
  final User user;
  final TextStyle subtextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 30,
            width: 30,
            color: const Color(0xff4CC2B4),
            child: const Icon(
              Icons.done,
              fill: 1,
              size: 20,
              color: Colors.white,
            )),
        const SizedBox(width: 12),
        SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                getStatus(order.status),
                style: subtextStyle,
              ),
              Text(
                capitalizeFirstLetter(string: user.name),
                style: subtextStyle,
              ),
              Text(
                user.address,
                style: subtextStyle,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return TrackingDetailsBottomSheet(
                          order: order,
                          user: user,
                        );
                      });
                },
                child: Text(
                  'See all updates',
                  style: subtextStyle.copyWith(
                      color: Constants.selectedNavBarColor),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
