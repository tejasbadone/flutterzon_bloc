import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/router.dart';
import 'package:flutter_amazon_clone_bloc/src/config/themes/app_theme.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/auth_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_account_screen_data/fetch_account_screen_data_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_orders/fethc_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/keep_shopping_for/cubit/keep_shopping_for_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/product_rating/product_rating_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/wish_list/wish_list_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/four-images-offer/admin_four_image_offer_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/single_image_carousel_cubit/single_image_carousel_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/add_product_images/admin_add_products_images_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/select_category_cubit/admin_add_select_category_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/sell_product_cubit/admin_sell_product_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_bottom_bar_cubit/admin_bottom_bar_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_change_order_status/admin_change_order_status_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_fetch_category_products/admin_fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_fetch_orders/admin_fetch_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_get_analytics/admin_get_analytics_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/auth_bloc/radio_bloc/radio_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit1/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit2/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit3/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/carousel_bloc/carousel_image_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/deal_of_the_day/deal_of_the_day_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/order/order_cubit/order_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/order/place_order_buy_now/place_order_buy_now_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/page_redirection_cubit/page_redirection_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/product_details/averageRating/average_rating_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/product_details/user_rating/user_rating_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/search/bloc/search_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
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
          create: (context) => RadioBloc(),
        ),
        BlocProvider(
          create: (context) => UserCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => CartBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => PageRedirectionCubit(AuthRepository()),
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
          create: (context) => SearchBloc(ProductsRepository()),
        ),
        BlocProvider(
          create: (context) => FetchAccountScreenDataCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => FetchOrdersCubit(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => ProductRatingBloc(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => KeepShoppingForCubit(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => WishListCubit(
              accountRepository: AccountRepository(),
              userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) => UserRatingCubit(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => CartOffersCubit1(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => CartOffersCubit2(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => CartOffersCubit3(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => OrderCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => PlaceOrderBuyNowCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => AverageRatingCubit(AccountRepository()),
        ),
        BlocProvider(create: (context) => AdminBottomBarCubit()),
        BlocProvider(
            create: (context) =>
                AdminFetchCategoryProductsBloc(AdminRepository())),
        BlocProvider(
            create: (context) => AdminFetchOrdersCubit(AdminRepository())),
        BlocProvider(
            create: (context) =>
                AdminChangeOrderStatusCubit(AdminRepository())),
        BlocProvider(
            create: (context) => AdminGetAnalyticsCubit(AdminRepository())),
        BlocProvider(
            create: (context) => AdminAddProductsImagesBloc(AdminRepository())),
        BlocProvider(create: (context) => AdminAddSelectCategoryCubit()),
        BlocProvider(create: (context) => SingleImageCubit()),
        BlocProvider(
            create: (context) => AdminSellProductCubit(AdminRepository())),
        BlocProvider(
            create: (context) => AdminFourImageOfferCubit(AdminRepository())),
        BlocProvider(
            create: (context) => DealOfTheDayCubit(ProductsRepository())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
