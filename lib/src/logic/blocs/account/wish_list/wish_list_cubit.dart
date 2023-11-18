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
}
