part of 'admin_add_products_bloc.dart';

sealed class AdminAddProductsEvent extends Equatable {
  const AdminAddProductsEvent();

  @override
  List<Object> get props => [];
}

class SelectImagesPressedE extends AdminAddProductsEvent {
  @override
  List<Object> get props => [];
}

class SelectCategoryPressedE extends AdminAddProductsEvent {
  final String category;

  const SelectCategoryPressedE({required this.category});
  @override
  List<Object> get props => [category];
}
