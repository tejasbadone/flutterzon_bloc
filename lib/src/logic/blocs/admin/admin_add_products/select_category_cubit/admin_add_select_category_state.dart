part of 'admin_add_select_category_cubit.dart';

sealed class AdminAddSelectCategoryState extends Equatable {
  const AdminAddSelectCategoryState();

  @override
  List<Object> get props => [];
}

final class AdminAddSelectCategoryInitial extends AdminAddSelectCategoryState {}

final class AdminAddProductsSelectCategory extends AdminAddSelectCategoryState {
  final String category;

  const AdminAddProductsSelectCategory({required this.category});

  @override
  List<Object> get props => [category];
}

final class AdminSelectCategoryErrorS extends AdminAddSelectCategoryState {
  final String errorString;

  const AdminSelectCategoryErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
