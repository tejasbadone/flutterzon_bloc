import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/order_list_single.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class YourOrders extends StatefulWidget {
  static const String routeName = 'your-orders';
  const YourOrders({super.key});

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchOrders();
  // }

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
                  onFieldSubmitted: (query) {
                    // Navigator.pushNamed(context, SearchOrderScreeen.routeName,
                    //     arguments: query);
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
            // ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: 3,
            //     itemBuilder: ((context, index) {
            //       return OrderListSingle(
            //         order: null,
            //       );
            //     }))
          ],
        ),
      ),
    );
  }
}
