part of 'fetch_category_products_bloc.dart';

sealed class FetchCategoryProductsState extends Equatable {
  const FetchCategoryProductsState();

  @override
  List<Object> get props => [];
}

final class FetchCategoryProductsLoadingS extends FetchCategoryProductsState {}

final class FetchCategoryProductsSuccessS extends FetchCategoryProductsState {
  final List<Product> productList;

  const FetchCategoryProductsSuccessS({required this.productList});

  @override
  List<Object> get props => [productList];
}

final class FetchCategoryProductsErrorS extends FetchCategoryProductsState {
  final String errorString;

  const FetchCategoryProductsErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
