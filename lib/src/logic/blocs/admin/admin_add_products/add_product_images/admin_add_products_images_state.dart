part of 'admin_add_products_images_bloc.dart';

sealed class AdminAddProductsImagesState extends Equatable {
  const AdminAddProductsImagesState();

  @override
  List<Object> get props => [];
}

final class AdminAddProductsLoadingS extends AdminAddProductsImagesState {}

final class AdminAddProductsInitialS extends AdminAddProductsImagesState {}

final class AdminAddProductsClearImagesS extends AdminAddProductsImagesState {}

final class AdminAddProductsImagesSelectedS
    extends AdminAddProductsImagesState {
  final List<File> imagesList;

  const AdminAddProductsImagesSelectedS({required this.imagesList});
  @override
  List<Object> get props => [imagesList];
}

final class AdminAddProductsErrorS extends AdminAddProductsImagesState {
  final String errorString;

  const AdminAddProductsErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
