part of 'admin_add_products_bloc.dart';

sealed class AdminAddProductsState extends Equatable {
  const AdminAddProductsState();

  @override
  List<Object> get props => [];
}

final class AdminAddProductsLoadingS extends AdminAddProductsState {}

final class AdminAddProductsInitialS extends AdminAddProductsState {}

final class AdminAddProductsImagesSelectedS extends AdminAddProductsState {
  final List<File> imagesList;

  const AdminAddProductsImagesSelectedS({required this.imagesList});
  @override
  List<Object> get props => [imagesList];
}

final class AdminAddProductsErrorS extends AdminAddProductsState {
  final String errorString;

  const AdminAddProductsErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
