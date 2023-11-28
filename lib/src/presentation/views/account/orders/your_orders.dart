import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_orders/fethc_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/order_list_single.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class YourOrders extends StatelessWidget {
  const YourOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Text(
                'Your Orders',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 52,
              padding: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.8), width: 0.5),
                  top: BorderSide(
                      color: Colors.grey.withOpacity(0.8), width: 0.5),
                ),
              ),
              child: Center(
                child: TextFormField(
                  onFieldSubmitted: (orderQuery) {
                    context.pushNamed(
                        AppRouteConstants.searchOrdersScreenRoute.name,
                        pathParameters: {
                          'orderQuery': orderQuery,
                        });
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        size: 30,
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(minHeight: 42, maxHeight: 42),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 10,
                        width: 95,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: Colors.grey.withOpacity(0.8),
                                width: 0.5),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 16,
                              color: Colors.black87,
                            )
                          ],
                        ),
                      ),
                      hintText: 'Search all orders',
                      hintStyle: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.normal),
                      prefixIconColor: Constants.selectedNavBarColor,
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<FetchOrdersCubit, FetchOrdersState>(
              listener: (context, state) {
                if (state is FetchOrdersErrorAS) {
                  showSnackBar(context, state.errorString);
                }
              },
              builder: (context, state) {
                if (state is FetchOrdersLoadingAS) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is FetchOrdersSuccessAS) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.ordersList.length,
                    itemBuilder: ((context, index) {
                      return OrderListSingle(
                        order: state.ordersList[index],
                      );
                    }),
                  );
                }

                return const Text('null');
              },
            )
          ],
        ),
      ),
    );
  }
}
