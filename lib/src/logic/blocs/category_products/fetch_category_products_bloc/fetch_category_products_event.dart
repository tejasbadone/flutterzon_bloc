part of 'fetch_category_products_bloc.dart';

sealed class FetchCategoryProductsEvent extends Equatable {
  const FetchCategoryProductsEvent();

  @override
  List<Object> get props => [];
}

class CategoryPressedEvent extends FetchCategoryProductsEvent {
  final String category;

  const CategoryPressedEvent({required this.category});

  @override
  List<Object> get props => [category];
}
