import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
part 'cart_offers_state.dart';

class CartOffersCubit1 extends Cubit<CartOffersState1> {
  final AccountRepository accountRepository;
  final CategoryProductsRepository categoryProductsRepository =
      CategoryProductsRepository();
  CartOffersCubit1(this.accountRepository) : super(CartOffersInitial1());

  Future<List<String>> setOfferCategories() async {
    String category1 = '';
    String category2 = '';
    String category3 = '';

    List<Product> productList;

    productList = await accountRepository.getKeepShoppingFor();

    if (productList.isNotEmpty && productList.length >= 3) {
      for (int i = 0; i < productList.length; i++) {
        if (category1 == '') {
          category1 = productList[i].category;
        } else if (category2 == '' &&
            category1 != '' &&
            category1 != productList[i].category) {
          category2 = productList[i].category;
        } else if (category3 == '' &&
            category1 != '' &&
            category2 != '' &&
            category1 != productList[i].category &&
            category2 != productList[i].category) {
          category3 = productList[i].category;
        }
      }
      return [category1, category2, category3];
    } else {
      int index = Random().nextInt(8);
      category1 = Constants.categoryImages[index]['title']!;
      int index1 = Random().nextInt(8);
      category2 = Constants.categoryImages[index1]['title']!;
      int index2 = Random().nextInt(8);
      category3 = Constants.categoryImages[index2]['title']!;
      return [category1, category2, category3];
    }
  }

  void cartOffers1({required String category}) async {
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

      emit(CartOffersSuccessS1(
          productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(CartOffersErrorS1(errorString: e.toString()));
    }
  }
}
