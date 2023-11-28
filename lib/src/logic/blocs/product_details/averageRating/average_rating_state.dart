part of 'average_rating_cubit.dart';

sealed class AverageRatingState extends Equatable {
  const AverageRatingState();

  @override
  List<Object> get props => [];
}

final class AverageRatingLoadingS extends AverageRatingState {}

final class AverageRatingSuccessS extends AverageRatingState {
  final double averageRating;
  final int averageRatingLength;

  const AverageRatingSuccessS(
      {required this.averageRating, required this.averageRatingLength});
  @override
  List<Object> get props => [averageRating, averageRatingLength];
}
