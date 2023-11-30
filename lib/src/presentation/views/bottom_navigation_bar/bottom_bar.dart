import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/account/account_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/another_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/cart/cart_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/home/home_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/menu/menu_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/bottom_bar/custom_bottom_nav_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/bottom_bar/custom_bottom_sheet.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const AnotherScreen(appBarTitle: 'More Screen'),
    const CartScreen(),
    const MenuScreen(),
  ];

  bool isOpen = false;
  int lastIndex = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUserData();
    context.read<CartBloc>().add(GetCartPressed());

    return BlocBuilder<BottomBarBloc, BottomBarState>(
        builder: (context, state) {
      if (state is BottomBarMoreClickedState) {
        return Scaffold(
            body: Scaffold(
              body: GestureDetector(
                onTap: () {
                  BlocProvider.of<BottomBarBloc>(context)
                      .add(BottomBarMoreClickedEvent(state.index, false));
                  context
                      .read<BottomBarBloc>()
                      .add(BottomBarClickedEvent(index: lastIndex));
                },
                child: Stack(
                  children: [
                    pages[lastIndex],
                    Container(
                      color: Colors.black87.withOpacity(0.5),
                    )
                  ],
                ),
              ),
            ),
            bottomSheet: state.isOpen
                ? BottomSheet(
                    backgroundColor: const Color(0xffffffff),
                    shadowColor: Colors.white,
                    dragHandleColor: const Color(0xffDDDDDD),
                    dragHandleSize: const Size(50, 4),
                    enableDrag: false,
                    showDragHandle: true,
                    constraints:
                        const BoxConstraints(minHeight: 400, maxHeight: 400),
                    onClosing: () {},
                    builder: (context) {
                      return const CustomBottomSheet();
                    })
                : null,
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: state.index,
              bottomNavBarList: items(index: state.index, isOpen: state.isOpen),
              onTap: (page) {
                if (page == 2) {
                  if (state.isOpen) {
                    BlocProvider.of<BottomBarBloc>(context)
                        .add(BottomBarMoreClickedEvent(page, false));
                    context
                        .read<BottomBarBloc>()
                        .add(BottomBarClickedEvent(index: lastIndex));
                  } else {
                    BlocProvider.of<BottomBarBloc>(context)
                        .add(BottomBarMoreClickedEvent(page, true));
                  }
                } else {
                  lastIndex = page;

                  context
                      .read<BottomBarBloc>()
                      .add(BottomBarClickedEvent(index: page));
                }
              },
            ));
      }
      if (state is BottomBarPageState) {
        return Scaffold(
            body: pages[state.index],
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: state.index,
              bottomNavBarList: items(index: state.index),
              onTap: (page) {
                if (page == 2) {
                  if (isOpen) {
                    BlocProvider.of<BottomBarBloc>(context)
                        .add(BottomBarMoreClickedEvent(page, false));
                    context
                        .read<BottomBarBloc>()
                        .add(BottomBarClickedEvent(index: lastIndex));
                  } else {
                    BlocProvider.of<BottomBarBloc>(context)
                        .add(BottomBarMoreClickedEvent(page, true));
                  }
                } else {
                  lastIndex = page;

                  context
                      .read<BottomBarBloc>()
                      .add(BottomBarClickedEvent(index: page));
                }
              },
            ));
      }
      return const SizedBox();
    });
  }

  List<BottomNavigationBarItem> items(
      {required int index, bool isOpen = false}) {
    return [
      bottomNavBarItem(
        index: index,
        iconName: 'home',
        isOpen: isOpen,
        page: 0,
        label: 'Home',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'you',
        isOpen: isOpen,
        page: 1,
        label: 'You',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'more',
        isOpen: isOpen,
        page: 2,
        label: 'More',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'cart',
        isOpen: isOpen,
        page: 3,
        label: 'Cart',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'menu',
        isOpen: isOpen,
        page: 4,
        label: 'Menu',
      ),
    ];
  }

  BottomNavigationBarItem bottomNavBarItem(
      {required String iconName,
      required int page,
      isOpen = false,
      required int index,
      required String label,
      double height = 20,
      double width = 20}) {
    return BottomNavigationBarItem(
        icon: Column(
          children: [
            Container(
              width: 42,
              height: 5.5,
              decoration: BoxDecoration(
                color: index == page && index != 2
                    ? Constants.selectedNavBarColor
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            page == 3
                ? Stack(
                    children: [
                      Image.asset('assets/images/bottom_nav_bar/$iconName.png',
                          height: 25,
                          width: 30,
                          color: index == page
                              ? Constants.selectedNavBarColor
                              : Constants.unselectedNavBarColor),
                      Positioned(
                        top: 0,
                        left: 13,
                        child: Builder(builder: (context) {
                          CartState state = context.watch<CartBloc>().state;
                          if (state is CartProductSuccessS) {
                            int cartLength = state.cartProducts.length;

                            return Text(
                              cartLength.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index == page
                                      ? Constants.selectedNavBarColor
                                      : Constants.unselectedNavBarColor),
                            );
                          }
                          return Text(
                            '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index == page
                                    ? Constants.selectedNavBarColor
                                    : Constants.unselectedNavBarColor),
                          );
                        }),
                      ),
                    ],
                  )
                : Image.asset('assets/images/bottom_nav_bar/$iconName.png',
                    height: height,
                    width: width,
                    color: index == page
                        ? Constants.selectedNavBarColor
                        : Constants.unselectedNavBarColor),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        label: label);
  }
}
