import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';

part 'cart_offers_state.dart';

class CartOffersCubit2 extends Cubit<CartOffersState2> {
  final AccountRepository accountRepository;
  final CategoryProductsRepository categoryProductsRepository =
      CategoryProductsRepository();
  CartOffersCubit2(this.accountRepository) : super(CartOffersInitial2());

  void cartOffers2({required String category}) async {
    try {
      List<Product> productList;
      List<double> averageRatingList = [];
      double rating = 0;

      productList =
          await categoryProductsRepository.fetchCategoryProducts(category);
      productList.shuffle();

      for (int i = 0; i < productList.length; i++) {
        rating = await accountRepository.getAverageRating(productList[i].id!);
        averageRatingList.add(rating);
      }

      emit(CartOffersSuccessS2(
          productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(CartOffersErrorS2(errorString: e.toString()));
    }
  }
}
