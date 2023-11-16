import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'product_rating_event.dart';
part 'product_rating_state.dart';

class ProductRatingBloc
    extends Bloc<ProductRatingEventSealed, ProductRatingState> {
  final AccountRepository accountRepository;
  ProductRatingBloc(this.accountRepository)
      : super(const GetProductRatingInitialS(initialRating: -1)) {
    on<GetProductRatingEvent>(_onGetProductRatingHandler);
    on<RateProductPressedEvent>(_onRateProductPressedHandler);
  }

  Future<List<double>> _getProductRatingList(Order order) async {
    List<double> ratingsList = [];
    for (int i = 0; i < order.products.length; i++) {
      double rating =
          await accountRepository.getProductRating(order.products[i]);
      ratingsList.add(rating);
    }

    return ratingsList;
  }

  void _onGetProductRatingHandler(event, emit) async {
    try {
      emit(const GetProductRatingInitialS(initialRating: -1));

      List<double> ratingsList = [];
      ratingsList = await _getProductRatingList(event.order);

      emit(GetProductRatingSuccessS(ratingsList: ratingsList));
    } catch (e) {
      emit(GetProductRatingErrorS(errorString: e.toString()));
    }
  }

  // rate product and fetch ratings again
  void _onRateProductPressedHandler(event, emit) async {
    try {
      List<double> ratingsList = [];
      ratingsList = await _getProductRatingList(event.order);
      emit(RateProductInitialS(ratingsList: ratingsList));

      accountRepository.rateProduct(
          product: event.product, rating: event.rating);

      List<double> updatedRatingsList =
          await _getProductRatingList(event.order);

      emit(RateProductSuccessS(updatedRatingsList: updatedRatingsList));
    } catch (e) {
      emit(RateProductErrorS(errorString: e.toString()));
    }
  }
}
