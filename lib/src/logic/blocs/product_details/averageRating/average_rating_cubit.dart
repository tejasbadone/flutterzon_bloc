import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'average_rating_state.dart';

class AverageRatingCubit extends Cubit<AverageRatingState> {
  final AccountRepository accountRepository;
  AverageRatingCubit(this.accountRepository) : super(AverageRatingInitial());

  Future<double> getProductAverageRating({required String productId}) async {
    double rating;

    rating = await accountRepository.getAverageRating(productId);

    return rating;
  }
}
