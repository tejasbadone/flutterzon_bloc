import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/order_list_single.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';

class SearchOrderScreeen extends StatefulWidget {
  static const String routeName = '/search-order-screen';
  const SearchOrderScreeen({super.key, required this.orderQuery});

  final String orderQuery;

  @override
  State<SearchOrderScreeen> createState() => _SearchOrderScreeenState();
}

class _SearchOrderScreeenState extends State<SearchOrderScreeen> {
  // final AccountServices accountServices = AccountServices();
  // List<Order>? ordersList;

  // fetchOrderedProducts() async {
  //   ordersList = await accountServices.searchOrder(
  //       context: context, searchQuery: widget.orderQuery);

  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchOrderedProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '{lengh here} order(s) matching "${widget.orderQuery}"',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // ListView.builder(
              //   itemCount: 3,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: ((context, index) {
              //     return OrderListSingle(order: null);
              //   }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
