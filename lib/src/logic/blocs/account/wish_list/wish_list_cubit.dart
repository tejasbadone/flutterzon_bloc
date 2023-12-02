import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final AccountRepository accountRepository;
  final UserRepository userRepository;
  WishListCubit({required this.accountRepository, required this.userRepository})
      : super(GetWishListLoadingS());

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

  void wishList({required Product product}) async {
    try {
      emit(GetWishListLoadingS());

      bool isWishListed =
          await accountRepository.isWishListed(product: product);

      if (isWishListed) {
        emit(AddedToWishListS(product: product));
      } else {
        emit(NotAddedToWishListS(product: product));
      }
    } catch (e) {
      emit(GetWishListErrorS(errorString: e.toString()));
    }
  }

  Future<void> addToWishList({required Product product}) async {
    try {
      accountRepository.addToWishList(product: product);

      emit(AddedToWishListS(product: product));
    } catch (e) {
      emit(WishListErrorS(errorString: e.toString()));
    }
  }

  void deleteFromWishList({required Product product}) async {
    try {
      accountRepository.deleteFromWishList(product: product);

      emit(DeletedFromWishListS(product: product));
    } catch (e) {
      emit(WishListErrorS(errorString: e.toString()));
    }
  }

// Wish list screen

  void removedFromWishListScreen({required Product product}) async {
    try {
      List<Product> productList;
      List<double> averageRatings = [];

      emit(GetWishListLoadingS());

      bool isDeleted =
          await accountRepository.deleteFromWishList(product: product);

      if (isDeleted) {
        productList = await accountRepository.getWishList();

        for (int i = 0; i < productList.length; i++) {
          double averageRating =
              await accountRepository.getAverageRating(productList[i].id!);
          averageRatings.add(averageRating);
        }

        emit(GetWishListSuccessS(
            wishList: productList, averageRatingList: averageRatings));
      }
    } catch (e) {
      emit(GetWishListErrorS(errorString: e.toString()));
    }
  }

// Add to cart from wishlist

  void addToCartFromWishList({required Product product}) async {
    try {
      List<Product> wishList;
      List<double> averageRatingList = [];

      emit(GetWishListLoadingS());

      wishList = await userRepository.addToCartFromWishList(product: product);
      if (wishList.isNotEmpty) {
        for (int i = 0; i < wishList.length; i++) {
          double averageRating =
              await accountRepository.getAverageRating(wishList[i].id!);
          averageRatingList.add(averageRating);
        }

        emit(GetWishListSuccessS(
            wishList: wishList, averageRatingList: averageRatingList));
      }
    } catch (e) {
      emit(GetWishListErrorS(errorString: e.toString()));
    }
  }
}
