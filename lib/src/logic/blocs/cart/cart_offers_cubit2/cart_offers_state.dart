part of 'cart_offers_cubit.dart';

sealed class CartOffersState2 extends Equatable {
  const CartOffersState2();

  @override
  List<Object> get props => [];
}

final class CartOffersInitial2 extends CartOffersState2 {}

final class CartOffersSuccessS2 extends CartOffersState2 {
  final List<Product> productList;
  final List<double> averageRatingList;

  const CartOffersSuccessS2(
      {required this.productList, required this.averageRatingList});
  @override
  List<Object> get props => [productList, averageRatingList];
}

final class CartOffersErrorS2 extends CartOffersState2 {
  final String errorString;

  const CartOffersErrorS2({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
