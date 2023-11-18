import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'user_rating_state.dart';

class UserRatingCubit extends Cubit<UserRatingState> {
  final AccountRepository accountRepository;
  UserRatingCubit(this.accountRepository) : super(UserRatingInitialS());

  void userRating(Product product) async {
    try {
      emit(UserRatingInitialS());

      double rating;

      rating = await accountRepository.getProductRating(product);

      emit(UserRatingSuccessS(userRating: rating));
    } catch (e) {
      emit(UserRatingErrorS(errorString: e.toString()));
    }
  }

  void updateUserRating(
      {required double userRating, required Product product}) async {
    try {
      emit(UpdateUserRatingInitialS());

      accountRepository.rateProduct(product: product, rating: userRating);

      emit(UpdateUserRatingSuccessS(userRating: userRating));
    } catch (e) {
      emit(UserRatingErrorS(errorString: e.toString()));
    }
  }
}
