part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoadingS extends CartState {}

final class CartProductSuccessS extends CartState {
  final List<Product> cartProducts;
  final List<int> productsQuantity;
  final double total;

  const CartProductSuccessS(
    this.total,
    this.cartProducts,
    this.productsQuantity,
  );

  @override
  List<Object> get props => [cartProducts, productsQuantity, total];
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
