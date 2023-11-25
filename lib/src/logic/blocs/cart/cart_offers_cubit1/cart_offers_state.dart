part of 'cart_offers_cubit.dart';

sealed class CartOffersState1 extends Equatable {
  const CartOffersState1();

  @override
  List<Object> get props => [];
}

final class CartOffersInitial1 extends CartOffersState1 {}

final class CartOffersLoadingS1 extends CartOffersState1 {}

final class CartOffersSuccessS1 extends CartOffersState1 {
  final List<Product> productList;
  final List<double> averageRatingList;

  const CartOffersSuccessS1(
      {required this.productList, required this.averageRatingList});
  @override
  List<Object> get props => [productList, averageRatingList];
}

final class CartOffersErrorS1 extends CartOffersState1 {
  final String errorString;

  const CartOffersErrorS1({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
