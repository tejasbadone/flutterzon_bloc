part of 'admin_fetch_category_products_bloc.dart';

sealed class AdminFetchCategoryProductsState extends Equatable {
  const AdminFetchCategoryProductsState();

  @override
  List<Object> get props => [];
}

final class AdminFetchCategoryProductsLoadingS
    extends AdminFetchCategoryProductsState {}

final class AdminFetchCategoryProductsSuccessS
    extends AdminFetchCategoryProductsState {
  final List<Product> categoryProducts;

  const AdminFetchCategoryProductsSuccessS({required this.categoryProducts});
  @override
  List<Object> get props => [categoryProducts];
}

final class AdminFetchCategoryProductsErrorS
    extends AdminFetchCategoryProductsState {
  final String errorString;

  const AdminFetchCategoryProductsErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
