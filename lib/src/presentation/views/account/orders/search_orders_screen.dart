import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_orders_bloc/fetch_orders_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/orders/order_list_single.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchOrderScreeen extends StatelessWidget {
  const SearchOrderScreeen({super.key, required this.orderQuery});

  final String orderQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: BlocConsumer<FetchOrdersBloc, FetchOrdersState>(
        listener: (context, state) {
          if (state is FetchOrdersErrorS) {
            return showSnackBar(context, state.errorString);
          }
        },
        builder: (context, state) {
          if (state is FetchOrdersLoadingS) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchOrdersSuccessS) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.ordersList.length} order(s) matching "$orderQuery"',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: state.ordersList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return OrderListSingle(order: state.ordersList[index]);
                      }),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
