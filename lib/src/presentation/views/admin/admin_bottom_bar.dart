import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_bottom_bar_cubit/admin_bottom_bar_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/admin/admin_home_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_analytics_screen.dart';
import 'admin_orders_screen.dart';

class AdminBottomBar extends StatelessWidget {
  const AdminBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUserData();

    List<Widget> pages = [
      const AdminHomeScreen(),
      const AdminAnalyticsScreen(),
      const AdminOrdersScreen()
    ];
    return BlocBuilder<AdminBottomBarCubit, AdminBottomBarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              flexibleSpace: Container(
                decoration:
                    const BoxDecoration(gradient: Constants.appBarGradient),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    width: 120,
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/images/amazon_black_logo.png'),
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: BottomNavigationBar(
              currentIndex: state.index,
              selectedLabelStyle:
                  TextStyle(color: Constants.selectedNavBarColor, fontSize: 13),
              unselectedLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 13),
              selectedItemColor: Constants.selectedNavBarColor,
              unselectedItemColor: Constants.unselectedNavBarColor,
              backgroundColor: Constants.backgroundColor,
              enableFeedback: false,
              iconSize: 28,
              elevation: 0,
              onTap: (page) {
                context.read<AdminBottomBarCubit>().adminBottomBar(index: page);
              },
              items: [
                bottomNavBarItem(
                    icon: const Icon(Icons.home_outlined),
                    page: 0,
                    index: state.index,
                    label: 'Home'),
                bottomNavBarItem(
                    icon: const Icon(Icons.analytics_outlined),
                    page: 1,
                    index: state.index,
                    label: 'Analytics'),
                bottomNavBarItem(
                    icon: const Icon(Icons.local_shipping_outlined),
                    page: 2,
                    index: state.index,
                    label: 'Orders'),
              ],
            ),
          ),
          body: pages[state.index],
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavBarItem(
      {required Widget icon,
      required int page,
      required String label,
      required int index}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Container(
            width: 38,
            height: 6,
            decoration: BoxDecoration(
              color:
                  index == page ? Constants.selectedNavBarColor : Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          icon
        ],
      ),
      label: label,
    );
  }
}
