import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';

part 'fetch_account_screen_data_state.dart';

class FetchAccountScreenDataCubit extends Cubit<FetchAccountScreenDataState> {
  final UserRepository userRepository;
  final AccountRepository accountRepository = AccountRepository();
  FetchAccountScreenDataCubit(this.userRepository)
      : super(FetchAccountScreenDataLoadingS());

  void getAccountScreenData() async {
    try {
      List<Order> ordersList;
      List<Order> tempOrdersList;
      List<Product> keepShoppingForList = [];
      List<Product> keepShoppingForListTemp = [];
      List<Product> wishListProducts = [];
      List<double> averageRatingList = [];

      tempOrdersList = await AccountRepository().fetchMyOrders();
      ordersList = tempOrdersList.reversed.toList();

      User user = await userRepository.getUserData();

      for (int i = 0; i < user.keepShoppingFor.length; i++) {
        keepShoppingForListTemp
            .add(Product.fromMap(user.keepShoppingFor[i]['product']));
      }
      keepShoppingForList = keepShoppingForListTemp.reversed.toList();

      for (int i = 0; i < user.wishList.length; i++) {
        Product product = Product.fromMap(user.wishList[i]['product']);
        wishListProducts.add(product);

        double averageRating =
            await accountRepository.getAverageRating(product.id!);
        averageRatingList.add(averageRating);
      }

      if (ordersList.isEmpty &&
          keepShoppingForList.isEmpty &&
          wishListProducts.isEmpty) {
        emit(const FetchAccountScreenDataEmptyS(
            emptyStringMessage:
                'Your account is currently empty. Start adding items to your orders, wishlist, and history to see them here.'));
      } else {
        emit(FetchAccountScreenDataSuccessS(
          ordersList: ordersList,
          keepShoppingForList: keepShoppingForList,
          wishListProducts: wishListProducts,
          averageRatingList: averageRatingList,
        ));
      }
    } catch (e) {
      emit(FetchAccountScreenDataErrorS(errorString: e.toString()));
    }
  }
}
