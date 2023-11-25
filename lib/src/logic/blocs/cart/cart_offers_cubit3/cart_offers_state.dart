part of 'cart_offers_cubit.dart';

sealed class CartOffersState3 extends Equatable {
  const CartOffersState3();

  @override
  List<Object> get props => [];
}

final class CartOffersInitial3 extends CartOffersState3 {}

final class CartOffersSuccessS3 extends CartOffersState3 {
  final List<Product> productList;
  final List<double> averageRatingList;

  const CartOffersSuccessS3(
      {required this.productList, required this.averageRatingList});
  @override
  List<Object> get props => [productList, averageRatingList];
}

final class CartOffersErrorS3 extends CartOffersState3 {
  final String errorString;

  const CartOffersErrorS3({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
