import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/wish_list/wish_list_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Wish List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              TextButton(
                  onPressed: () {
                    context.pushNamed(
                        AppRouteConstants.yourWishListScreenRoute.name);
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Constants.selectedNavBarColor),
                  ))
            ],
          ),
          BlocConsumer<WishListCubit, WishListState>(
            listener: (context, state) {
              if (state is GetWishListErrorS) {
                showSnackBar(context, state.errorString);
              }
            },
            builder: (context, state) {
              if (state is GetWishListLoadingS) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is GetWishListSuccessS) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 15,
                    childAspectRatio: state.wishList.length == 1
                        ? 2.0
                        : state.wishList.length == 3
                            ? 0.7
                            : 1.15,
                    crossAxisCount:
                        state.wishList.length >= 4 ? 2 : state.wishList.length,
                  ),
                  itemCount:
                      state.wishList.length >= 4 ? 4 : state.wishList.length,
                  itemBuilder: (context, index) {
                    if (state.wishList.length >= 6) {
                      index = getUniqueRandomInt(max: state.wishList.length);
                    }
                    return InkWell(
                      onTap: () {
                        // Map<String, dynamic> arguments = {
                        //   'product':
                        //       Product.fromMap(user.wishList[index]['product']),
                        //   'deliveryDate': getDeliveryDate(),
                        // };

                        // Navigator.pushNamed(
                        //     context, ProductDetailsScreen.routeName,
                        //     arguments: arguments);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 6),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state.wishList[index].images[0],

                              // user.wishList[index]['product']
                              //     ['images'][0],
                              height: 110,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '  ${state.wishList[index].name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          )
                        ],
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
