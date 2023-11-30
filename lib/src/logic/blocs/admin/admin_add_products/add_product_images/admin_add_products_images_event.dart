part of 'admin_add_products_images_bloc.dart';

sealed class AdminAddProductsImagesEvent extends Equatable {
  const AdminAddProductsImagesEvent();

  @override
  List<Object> get props => [];
}

class SelectImagesPressedE extends AdminAddProductsImagesEvent {
  @override
  List<Object> get props => [];
}

class ClearImagesPressedE extends AdminAddProductsImagesEvent {
  @override
  List<Object> get props => [];
}
