import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/products_repository.dart';

part 'average_rating_state.dart';

class AverageRatingCubit extends Cubit<AverageRatingState> {
  final AccountRepository accountRepository;
  final ProductsRepository productsRepository = ProductsRepository();
  AverageRatingCubit(this.accountRepository) : super(AverageRatingLoadingS());

  void getProductAverageRating({required String productId}) async {
    try {
      emit(AverageRatingLoadingS());
      int averageRatingLength;
      double averageRating;

      averageRating = await accountRepository.getAverageRating(productId);
      averageRatingLength =
          await productsRepository.getAverageRatingLength(productId: productId);

      emit(AverageRatingSuccessS(
          averageRating: averageRating,
          averageRatingLength: averageRatingLength));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
