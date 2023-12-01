part of 'deal_of_the_day_cubit.dart';

sealed class DealOfTheDayState extends Equatable {
  const DealOfTheDayState();

  @override
  List<Object> get props => [];
}

final class DealOfTheDayInitialS extends DealOfTheDayState {}

final class DealOfTheDaySuccessS extends DealOfTheDayState {
  final Product product;
  final int imageIndex;

  const DealOfTheDaySuccessS({required this.product, required this.imageIndex});

  @override
  List<Object> get props => [product, imageIndex];
}

final class DealOfTheDayErrorS extends DealOfTheDayState {
  final String errorString;

  const DealOfTheDayErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
