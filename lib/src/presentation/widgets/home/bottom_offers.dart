import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:go_router/go_router.dart';

class BottomOffers extends StatelessWidget {
  const BottomOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 4, right: 0),
        itemCount: Constants.bottomOfferImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          // if (index == 0) {
          //   return const Row(
          //     children: [
          //       SingleBottomOffer(
          //         mapName: GlobalVariables.bottomOffersAmazonPay,
          //       ),
          //     ],
          //   );
          // } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () {
                if (Constants.bottomOfferImages[index]['category'] ==
                    'AmazonPay') {
                  if (context.mounted) {
                    showSnackBar(context, 'Amazon Pay coming soon!');
                  }
                } else {
                  context.pushNamed(
                      AppRouteConstants.categoryproductsScreenRoute.name,
                      pathParameters: {
                        'category': Constants.bottomOfferImages[index]
                            ['category']!
                      });
                }
              },
              child: CachedNetworkImage(
                imageUrl: Constants.bottomOfferImages[index]['image']!,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
          // }
        }),
      ),
    );
  }
}
