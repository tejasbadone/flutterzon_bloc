// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_rating_bloc.dart';

sealed class ProductRatingState extends Equatable {
  const ProductRatingState();

  @override
  List<Object> get props => [];
}

final class GetProductRatingInitialS extends ProductRatingState {
  final double initialRating;

  const GetProductRatingInitialS({required this.initialRating});
  @override
  List<Object> get props => [initialRating];
}

final class GetProductRatingSuccessS extends ProductRatingState {
  final List<double> ratingsList;

  const GetProductRatingSuccessS({required this.ratingsList});
  @override
  List<Object> get props => [ratingsList];
}

final class GetProductRatingErrorS extends ProductRatingState {
  final String errorString;

  const GetProductRatingErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}

// rate product and read values again

class RateProductInitialS extends ProductRatingState {
  final List<double> ratingsList;

  const RateProductInitialS({required this.ratingsList});
  @override
  List<Object> get props => [ratingsList];
}

class RateProductS extends ProductRatingState {
  @override
  List<Object> get props => [];
}

class RateProductSuccessS extends ProductRatingState {
  final List<double> updatedRatingsList;
  const RateProductSuccessS({
    required this.updatedRatingsList,
  });
  @override
  List<Object> get props => [updatedRatingsList];
}

final class RateProductErrorS extends ProductRatingState {
  final String errorString;

  const RateProductErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
