import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_orders_bloc/fetch_orders_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/account_screen_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/keep_shopping_for.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/name_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/single_product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/top_buttons.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/wish_list.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account-screen';

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
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
                  const Positioned(top: 0, child: NameBar()),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Orders',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                          onPressed: () {
                            context.pushNamed(
                                AppRouteConstants.yourOrdersScreenRoute.name);
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
                  BlocConsumer<FetchOrdersBloc, FetchOrdersState>(
                    listener: ((context, state) {
                      if (state is FetchOrdersErrorS) {
                        showSnackBar(context, state.errorString);
                      }
                    }),
                    builder: (context, state) {
                      if (state is FetchOrdersLoadingS) {
                        return const OrdersLoadingWidget();
                      }

                      if (state is FetchOrdersSuccessS) {
                        return SizedBox(
                          height: 170,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.ordersList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        AppRouteConstants
                                            .orderDetailsScreenRoute.name,
                                        extra: state.ordersList[index]);
                                  },
                                  child: Container(
                                      width: 200,
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black12, width: 1.5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: state.ordersList.length == 1
                                          ? SingleProduct(
                                              image: state.ordersList[index]
                                                  .products[0].images[0],
                                            )
                                          : Row(
                                              children: [
                                                SingleProduct(
                                                  image: state.ordersList[index]
                                                      .products[0].images[0],
                                                ),
                                                Text(
                                                  '+ ${state.ordersList[index].products.length - 1}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                )
                                              ],
                                            )),
                                );
                              }),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            const DividerWithSizedBox(
              thickness: 4,
              sB1Height: 15,
              sB2Height: 0,
            ),
            // userProvider.user.keepShoppingFor.isNotEmpty
            const Column(
              children: [
                KeepShoppingFor(),
                DividerWithSizedBox(
                  thickness: 4,
                  sB1Height: 15,
                  sB2Height: 4,
                ),
              ],
            ),
            // const WishList(),

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
