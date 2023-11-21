import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/keep_shopping_for/cubit/keep_shopping_for_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KeepShoppingFor extends StatelessWidget {
  const KeepShoppingFor({
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
                'Keep shopping for',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              TextButton(
                  onPressed: () {
                    context.pushNamed(
                        AppRouteConstants.browsingHistoryScreenRoute.name);
                  },
                  child: Text(
                    'Browsing history',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Constants.selectedNavBarColor),
                  ))
            ],
          ),
          BlocConsumer<KeepShoppingForCubit, KeepShoppingForState>(
            listener: (context, state) {
              if (state is KeepShoppingForErrorS) {
                showSnackBar(context, state.errorString);
              }
            },
            builder: (context, state) {
              if (state is KeepShoppingForLoadingS) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is KeepShoppingForSuccessS) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 15,
                    childAspectRatio: state.productList.length == 1
                        ? 2.0
                        : state.productList.length == 3
                            ? 0.7
                            : 1.15,
                    crossAxisCount: state.productList.length >= 4
                        ? 2
                        : state.productList.length,
                  ),
                  itemCount: state.productList.length >= 4
                      ? 4
                      : state.productList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.pushNamed(
                            AppRouteConstants.categoryproductsScreenRoute.name,
                            pathParameters: {
                              "category": state.productList[index].category
                            });
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
                              imageUrl: state.productList[index].images[0],
                              height: 90,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.productList[index].category,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          )
                        ],
                      ),
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
