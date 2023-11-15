import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/router.dart';
import 'package:flutter_amazon_clone_bloc/src/config/themes/app_theme.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/auth_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/search_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/bloc/fetch_orders_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/carousel_bloc/carousel_image_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/search/bloc/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "config.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => FetchOrdersBloc(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => BottomBarBloc(),
        ),
        BlocProvider(
          create: (context) => CarouselImageBloc(),
        ),
        BlocProvider(
          create: (context) =>
              FetchCategoryProductsBloc(CategoryProductsRepository()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(SearchProductsRepository()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
