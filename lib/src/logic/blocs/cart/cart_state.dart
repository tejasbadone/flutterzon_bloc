part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoadingS extends CartState {}

final class CartProductSuccessS extends CartState {
  final List<Product> cartProducts;
  final List<Product> saveForLaterProducts;
  final List<double> averageRatingList;
  final List<int> productsQuantity;
  final double total;

  const CartProductSuccessS({
    required this.total,
    required this.cartProducts,
    required this.productsQuantity,
    required this.averageRatingList,
    required this.saveForLaterProducts,
  });

  @override
  List<Object> get props => [
        cartProducts,
        productsQuantity,
        total,
        saveForLaterProducts,
        averageRatingList
      ];
}

final class CartProductErrorS extends CartState {
  final String errorString;

  const CartProductErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

final class CartProductSubtotalS extends CartState {
  final double total;

  const CartProductSubtotalS({required this.total});

  @override
  List<Object> get props => [total];
}

final class SaveForLaterSuccessS extends CartState {
  final List<Product> saveForLaterProducts;

  const SaveForLaterSuccessS({required this.saveForLaterProducts});

  @override
  List<Object> get props => [saveForLaterProducts];
}
