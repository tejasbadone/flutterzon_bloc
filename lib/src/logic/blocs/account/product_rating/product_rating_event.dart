part of 'product_rating_bloc.dart';

sealed class ProductRatingEventSealed extends Equatable {
  const ProductRatingEventSealed();

  @override
  List<Object> get props => [];
}

class GetProductRatingEvent extends ProductRatingEventSealed {
  final Order order;

  const GetProductRatingEvent({required this.order});

  @override
  List<Object> get props => [order];
}

class RateProductPressedEvent extends ProductRatingEventSealed {
  final Product product;
  final double rating;
  final Order order;

  const RateProductPressedEvent(
      {required this.product, required this.rating, required this.order});

  @override
  List<Object> get props => [product, rating];
}
