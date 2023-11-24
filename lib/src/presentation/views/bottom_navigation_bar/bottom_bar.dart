import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_orders/fethc_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/keep_shopping_for/cubit/keep_shopping_for_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/wish_list/wish_list_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/account/account_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/another_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/cart/cart_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/home/home_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/menu/menu_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/bottom_bar/custom_bottom_sheet.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  int _currentIndex = 0;

  int _lastIndex = 0;

  bool isMoreScreen = false;

  bool isOpen = false;

  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),

    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FetchOrdersCubit(AccountRepository())..fetchOrders(),
        ),
        BlocProvider(
            create: (context) =>
                KeepShoppingForCubit(AccountRepository())..keepShoppingFor()),
        BlocProvider(
            create: (context) => WishListCubit(
                accountRepository: AccountRepository(),
                userRepository: UserRepository())
              ..getWishList()),
      ],
      child: const AccountScreen(),
    ),
    // ),
    const AnotherScreen(appBarTitle: 'More Screen'),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          final cartBloc = CartBloc(UserRepository());
          return cartBloc..add(GetCartPressed());
        }),
      ],
      child: const CartScreen(),
    ),
    const MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarBloc, BottomBarState>(
        listener: (context, state) {
      if (state is BottomBarPageState) {
        _lastIndex = _currentIndex;
        _currentIndex = state.index;
      }
      if (state is BottomBarMoreClickedState) {}
    }, builder: (context, state) {
      // ignore: no_leading_underscores_for_local_identifiers
      bool _isMoreScreen = state is BottomBarMoreClickedState;
      isMoreScreen = _isMoreScreen;

      return Scaffold(
        body: _currentIndex == 2 ? pages[_lastIndex] : pages[_currentIndex],
        bottomSheet: isOpen
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
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: SafeArea(
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  showSelectedLabels: _currentIndex == 2 ? false : true,
                  showUnselectedLabels: true,
                  selectedFontSize: 13,
                  unselectedFontSize: 13,
                  // selectedLabelStyle: TextStyle(
                  //     color:
                  //         _currentIndex == 2 && isOpen ? Colors.red : Colors.red,
                  //     fontSize: 13),
                  // unselectedLabelStyle: TextStyle(
                  //     color: _currentIndex == 2 && isOpen
                  //         ? Constants.selectedNavBarColor
                  //         : Constants.unselectedNavBarColor,
                  //     fontSize: 13),

                  // item colors means label colors
                  selectedItemColor: Constants.selectedNavBarColor,
                  unselectedItemColor: Constants.unselectedNavBarColor,
                  backgroundColor: Constants.backgroundColor,
                  enableFeedback: false,
                  iconSize: 28,
                  elevation: 0,
                  onTap: (page) {
                    _currentIndex != 2
                        ? _lastIndex = _currentIndex
                        : _lastIndex = _lastIndex;

                    _currentIndex = page;

                    if (page == 2) {
                      isOpen = !isOpen;

                      BlocProvider.of<BottomBarBloc>(context)
                          .add(BottomBarMoreClickedEvent(index: page));
                    } else {
                      BlocProvider.of<BottomBarBloc>(context)
                          .add(BottomBarClickedEvent(index: page));
                      isOpen = false;
                    }

                    if (page == 2 && isOpen == false && _currentIndex == 2) {
                      _currentIndex = _lastIndex;
                    }

                    debugPrint(
                        'current index - $_currentIndex, last index - $_lastIndex, isOpen - $isOpen');
                  },
                  items: [
                    bottomNavBarItem(
                      icon: bottomBarImage(iconName: 'home', page: 0),
                      page: 0,
                      label: 'Home',
                    ),
                    bottomNavBarItem(
                      icon: bottomBarImage(iconName: 'you', page: 1),
                      page: 1,
                      label: 'You',
                    ),
                    bottomNavBarItem(
                      icon: bottomBarImage(iconName: 'more', page: 2),
                      page: 2,
                      label: 'More',
                    ),
                    bottomNavBarItem(
                      icon: Stack(
                        children: [
                          bottomBarImage(
                              iconName: 'cart', page: 3, width: 25, height: 25),
                          Positioned(
                            top: 0,
                            left: 10,
                            child: Text(
                              '2',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _currentIndex == 3
                                      ? Constants.selectedNavBarColor
                                      : Constants.unselectedNavBarColor),
                            ),
                          ),
                        ],
                      ),
                      page: 3,
                      label: 'Cart',
                    ),
                    bottomNavBarItem(
                      icon: bottomBarImage(iconName: 'menu', page: 4),
                      page: 4,
                      label: 'Menu',
                    ),
                  ],
                )),
          ),
        ),
      );
      // }
    });
  }

  BottomNavigationBarItem bottomNavBarItem({
    required Widget icon,
    required int page,
    required String label,
  }) {
    return BottomNavigationBarItem(
        icon: Column(
          children: [
            Container(
              width: 42,
              height: 5.5,
              decoration: BoxDecoration(
                color: _lastIndex == page && isOpen == false
                    ? Constants.selectedNavBarColor
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            icon,
            const SizedBox(
              height: 6,
            ),
          ],
        ),
        label: label);
  }

  Image bottomBarImage(
      {required String iconName,
      required int page,
      double height = 20,
      double width = 20}) {
    return Image.asset('assets/images/bottom_nav_bar/$iconName.png',
        height: height,
        width: width,
        color: _currentIndex == page
            ? Constants.selectedNavBarColor
            : Constants.unselectedNavBarColor);
  }
}
