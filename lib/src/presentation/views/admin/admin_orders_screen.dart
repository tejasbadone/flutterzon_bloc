import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_fetch_orders/admin_fetch_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/single_product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminFetchOrdersCubit>().adminFetchOrders();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<AdminFetchOrdersCubit, AdminFetchOrdersState>(
            listener: (context, state) {
              if (state is AdminFetchOrdersErrorS) {
                showSnackBar(context, state.errorString);
              }
            },
            builder: (context, state) {
              if (state is AdminFetchOrdersErrorS) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is AdminFetchOrdersSuccessS) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Total ${state.ordersList.length} Orders',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: state.ordersList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final order = state.ordersList[index];
                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                                AppRouteConstants.orderDetailsScreenRoute.name,
                                extra: order);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: order.products.length == 1
                                        ? SingleProduct(
                                            image: order.products[0].images[0])
                                        : Row(
                                            children: [
                                              SingleProduct(
                                                  image: order
                                                      .products[0].images[0]),
                                              Text(
                                                ' + ${order.products.length - 1}',
                                                style: const TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          )),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Text(
                                          order.products[0].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
              return SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
