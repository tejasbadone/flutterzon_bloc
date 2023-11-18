import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';

part 'fetch_category_products_event.dart';
part 'fetch_category_products_state.dart';

class FetchCategoryProductsBloc
    extends Bloc<FetchCategoryProductsEvent, FetchCategoryProductsState> {
  final CategoryProductsRepository homeRepository;
  final AccountRepository accountRepository = AccountRepository();
  FetchCategoryProductsBloc(this.homeRepository)
      : super(FetchCategoryProductsLoadingS()) {
    on<FetchCategoryProductsEvent>(_onFetchCategoryProductsHandler);
  }

  void _onFetchCategoryProductsHandler(event, emit) async {
    try {
      List<Product> productList;
      List<double> averageRatingList = [];
      double rating;

      emit(FetchCategoryProductsLoadingS());

      productList = await homeRepository.fetchCategoryProducts(event.category);

      for (int i = 0; i < productList.length; i++) {
        rating = await accountRepository.getAverageRating(productList[i].id!);
        averageRatingList.add(rating);
      }

      emit(FetchCategoryProductsSuccessS(
          productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(FetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }
}
