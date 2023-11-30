part of 'admin_fetch_category_products_bloc.dart';

sealed class AdminFetchCategoryProductsEvent extends Equatable {
  const AdminFetchCategoryProductsEvent();

  @override
  List<Object> get props => [];
}

final class AdminFetchCategoryProductsPressedE
    extends AdminFetchCategoryProductsEvent {
  final String category;

  const AdminFetchCategoryProductsPressedE({required this.category});

  @override
  List<Object> get props => [category];
}

class AdminDeleteProductPressedE extends AdminFetchCategoryProductsEvent {
  final Product product;
  final String category;

  const AdminDeleteProductPressedE(
      {required this.product, required this.category});

  @override
  List<Object> get props => [product];
}
