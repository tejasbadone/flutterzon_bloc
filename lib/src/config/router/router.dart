import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/search_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/bloc/fetch_orders_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/search/bloc/search_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/another_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/auth/auth_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/bottom_navigation_bar/bottom_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/category_products/category_products_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/home/home_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/menu/menu_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/search/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _fetchCategoryProductsBloc =
    FetchCategoryProductsBloc(CategoryProductsRepository());

final _searchProductBloc = SearchBloc(SearchProductsRepository());

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: AppRouteConstants.authRoute.name,
    path: AppRouteConstants.authRoute.path,
    pageBuilder: (context, state) {
      return const MaterialPage(child: AuthScreen());
    },
  ),
  GoRoute(
    name: AppRouteConstants.bottomBarRoute.name,
    path: AppRouteConstants.bottomBarRoute.path,
    pageBuilder: (context, state) {
      return MaterialPage(child: BottomBar());
    },
  ),
  GoRoute(
    name: AppRouteConstants.homeScreenRoute.name,
    path: AppRouteConstants.homeScreenRoute.path,
    pageBuilder: (context, state) {
      return const MaterialPage(child: HomeScreen());
    },
  ),
  GoRoute(
    name: AppRouteConstants.anotherScreenRoute.name,
    path: AppRouteConstants.anotherScreenRoute.path,
    pageBuilder: (context, state) {
      final String appBarTitle = state.pathParameters['appBarTitle']!;
      return MaterialPage(
          child: AnotherScreen(
        appBarTitle: appBarTitle,
      ));
    },
  ),
  GoRoute(
    name: AppRouteConstants.categoryproductsScreenRoute.name,
    path: '${AppRouteConstants.categoryproductsScreenRoute.path}/:category',
    pageBuilder: (context, state) {
      final category = state.pathParameters['category'];

      return MaterialPage(
          child: BlocProvider.value(
        value: _fetchCategoryProductsBloc
          ..add(CategoryPressedEvent(category: category!)),
        child: CategoryProductsScreen(category: category),
      ));
    },
  ),
  GoRoute(
    name: AppRouteConstants.searchScreenRoute.name,
    path: '${AppRouteConstants.searchScreenRoute.path}/:searchQuery',
    pageBuilder: (context, state) {
      final searchQuery = state.pathParameters['searchQuery'];
      return MaterialPage(
          child: BlocProvider.value(
        value: _searchProductBloc..add(SearchEvent(searchQuery: searchQuery!)),
        child: SearchScreen(searchQuery: searchQuery),
      ));
    },
  ),
  GoRoute(
      name: AppRouteConstants.menuScreenRoute.name,
      path: AppRouteConstants.menuScreenRoute.path,
      pageBuilder: (context, state) {
        return const MaterialPage(child: MenuScreen());
      })
]);
