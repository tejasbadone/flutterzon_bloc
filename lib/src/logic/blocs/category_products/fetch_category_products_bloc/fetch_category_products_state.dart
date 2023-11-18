part of 'fetch_category_products_bloc.dart';

sealed class FetchCategoryProductsState extends Equatable {
  const FetchCategoryProductsState();

  @override
  List<Object> get props => [];
}

final class FetchCategoryProductsLoadingS extends FetchCategoryProductsState {}

final class FetchCategoryProductsSuccessS extends FetchCategoryProductsState {
  final List<Product> productList;
  final List<double> averageRatingList;

  const FetchCategoryProductsSuccessS(
      {required this.productList, required this.averageRatingList});

  @override
  List<Object> get props => [productList, averageRatingList];
}

final class FetchCategoryProductsErrorS extends FetchCategoryProductsState {
  final String errorString;

  const FetchCategoryProductsErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
