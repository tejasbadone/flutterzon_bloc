import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final AccountRepository accountRepository;
  WishListCubit(this.accountRepository) : super(GetWishListLoadingS());

  void getWishList() async {
    try {
      List<Product> wishList;
      List<double> averageRatingList = [];

      emit(GetWishListLoadingS());

      wishList = await accountRepository.getWishList();

      for (int i = 0; i < wishList.length; i++) {
        double averageRating =
            await accountRepository.getAverageRating(wishList[i].id!);
        averageRatingList.add(averageRating);
      }

      emit(GetWishListSuccessS(
          wishList: wishList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(GetWishListErrorS(errorString: e.toString()));
    }
  }

  void isWishListed({required Product product}) async {
    try {
      bool isWishListed =
          await accountRepository.isWishListed(product: product);

      print(isWishListed);

      if (isWishListed) {
        emit(AddToWishListSuccessS());
      }
    } catch (e) {
      emit(GetWishListErrorS(errorString: e.toString()));
    }
  }

  void addToWishList({required Product product}) async {
    try {
      emit(AddToWishListPressedS(product: product));

      accountRepository.addToWishList(product: product);

      emit(AddToWishListPressedS(product: product));
    } catch (e) {
      emit(AddToWishListErrorS(errorString: e.toString()));
    }
  }

  void deleteFromWishList({required Product product}) async {
    try {
      accountRepository.deleteFromWishList(product: product);

      emit(DeleteFromWishListS());
    } catch (e) {
      emit(AddToWishListErrorS(errorString: e.toString()));
    }
  }
}
