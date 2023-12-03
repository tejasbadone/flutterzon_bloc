import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_account_screen_data/fetch_account_screen_data_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/account_screen_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/name_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/single_product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/top_buttons.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<FetchAccountScreenDataCubit>().getAccountScreenData();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AccuntScreenAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                children: [
                  const Positioned(
                    top: 0,
                    child: NameBar(),
                  ),
                  Positioned(
                      top: 50,
                      child: Container(
                        height: 80,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.9)
                              ],
                              stops: const [
                                0,
                                0.45
                              ],
                              begin: AlignmentDirectional.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      )),
                  Positioned(
                    top: 60,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 200,
                        width: MediaQuery.sizeOf(context).width,
                        child: const TopButtons()),
                  ),
                ],
              ),
            ),

            // your orders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: BlocConsumer<FetchAccountScreenDataCubit,
                  FetchAccountScreenDataState>(
                listener: ((context, state) {
                  if (state is FetchAccountScreenDataErrorS) {
                    showSnackBar(context, state.errorString);
                  }
                }),
                builder: (context, state) {
                  if (state is FetchAccountScreenDataLoadingS) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchAccountScreenDataEmptyS) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(state.emptyStringMessage),
                      ),
                    );
                  }
                  if (state is FetchAccountScreenDataSuccessS) {
                    return Column(
                      children: [
                        state.ordersList.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Your Orders',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pushNamed(AppRouteConstants
                                              .yourOrdersScreenRoute.name);
                                        },
                                        child: Text(
                                          'See all',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Constants
                                                  .selectedNavBarColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 170,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.ordersList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              context.pushNamed(
                                                  AppRouteConstants
                                                      .orderDetailsScreenRoute
                                                      .name,
                                                  extra:
                                                      state.ordersList[index]);
                                            },
                                            child: Container(
                                                width: 200,
                                                margin: const EdgeInsets.all(8),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: state.ordersList[index]
                                                            .products.length ==
                                                        1
                                                    ? SingleProduct(
                                                        image: state
                                                            .ordersList[index]
                                                            .products[0]
                                                            .images[0],
                                                      )
                                                    : Row(
                                                        children: [
                                                          SingleProduct(
                                                            image: state
                                                                .ordersList[
                                                                    index]
                                                                .products[0]
                                                                .images[0],
                                                          ),
                                                          Text(
                                                            '+ ${state.ordersList[index].products.length - 1}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.grey
                                                                  .shade500,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                          );
                                        }),
                                  ),
                                  const DividerWithSizedBox(
                                    thickness: 4,
                                    sB1Height: 15,
                                    sB2Height: 0,
                                  ),
                                ],
                              ),

                        // Keep Shopping For
                        state.keepShoppingForList.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Keep shopping for',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pushNamed(AppRouteConstants
                                              .browsingHistoryScreenRoute.name);
                                        },
                                        child: Text(
                                          'Browsing history',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Constants
                                                  .selectedNavBarColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 15,
                                      childAspectRatio:
                                          state.keepShoppingForList.length == 1
                                              ? 2.0
                                              : state.keepShoppingForList
                                                          .length ==
                                                      3
                                                  ? 0.7
                                                  : 1.15,
                                      crossAxisCount:
                                          state.keepShoppingForList.length >= 4
                                              ? 2
                                              : state.keepShoppingForList
                                                      .isEmpty
                                                  ? 1
                                                  : state.keepShoppingForList
                                                      .length,
                                    ),
                                    itemCount:
                                        state.keepShoppingForList.length >= 4
                                            ? 4
                                            : state.keepShoppingForList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRouteConstants
                                                  .categoryproductsScreenRoute
                                                  .name,
                                              pathParameters: {
                                                "category": state
                                                    .keepShoppingForList[index]
                                                    .category
                                              });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 6),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: state
                                                    .keepShoppingForList[index]
                                                    .images[0],
                                                height: 110,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              state.keepShoppingForList[index]
                                                  .category,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const DividerWithSizedBox(
                                    thickness: 4,
                                    sB1Height: 6,
                                    sB2Height: 4,
                                  ),
                                ],
                              ),

                        // Wish List
                        state.wishListProducts.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Your Wish List',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            context.pushNamed(AppRouteConstants
                                                .yourWishListScreenRoute.name);
                                          },
                                          child: Text(
                                            'See all',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                color: Constants
                                                    .selectedNavBarColor),
                                          ))
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 15,
                                            childAspectRatio:
                                                state.wishListProducts.length ==
                                                        1
                                                    ? 2.0
                                                    : state.wishListProducts
                                                                .length ==
                                                            3
                                                        ? 0.7
                                                        : 1.15,
                                            crossAxisCount: state
                                                        .wishListProducts
                                                        .length >=
                                                    4
                                                ? 2
                                                : state.wishListProducts.isEmpty
                                                    ? 1
                                                    : state.wishListProducts
                                                        .length),
                                    itemCount:
                                        state.wishListProducts.length >= 4
                                            ? 4
                                            : state.wishListProducts.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRouteConstants
                                                  .productDetailsScreenRoute
                                                  .name,
                                              extra: {
                                                "product": state
                                                    .wishListProducts[index],
                                                "deliveryDate":
                                                    getDeliveryDate(),
                                              });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 6),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: state
                                                    .wishListProducts[index]
                                                    .images[0],
                                                height: 110,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '  ${state.wishListProducts[index].name}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              )
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OrdersLoadingWidget extends StatelessWidget {
  const OrdersLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12, width: 1.5),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
    );
  }
}
