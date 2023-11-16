import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/account/wish_list_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/account_button.dart';
import 'package:go_router/go_router.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(
                buttonName: 'Your Orders',
                onPressed: () {
                  context
                      .pushNamed(AppRouteConstants.yourOrdersScreenRoute.name);
                }
                // Navigator.pushNamed(context, YourOrders.routeName)
                ),
            const SizedBox(
              width: 10,
            ),
            AccountButton(buttonName: 'Buy Again', onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(buttonName: 'Log Out', onPressed: () {}
                // AccountServices().logOut(context)
                ),
            const SizedBox(
              width: 10,
            ),
            AccountButton(
                buttonName: 'Wish List',
                onPressed: () {
                  // Navigator.pushNamed(context, WishListScreen.routeName);
                }),
          ],
        ),
      ],
    );
  }
}
