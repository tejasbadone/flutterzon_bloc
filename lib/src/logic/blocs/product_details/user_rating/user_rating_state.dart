part of 'user_rating_cubit.dart';

sealed class UserRatingState extends Equatable {
  const UserRatingState();

  @override
  List<Object> get props => [];
}

final class UserRatingInitialS extends UserRatingState {}

final class UserRatingSuccessS extends UserRatingState {
  final double userRating;

  const UserRatingSuccessS({required this.userRating});
  @override
  List<Object> get props => [userRating];
}

final class UserRatingErrorS extends UserRatingState {
  final String errorString;

  const UserRatingErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}

// update user rating

class UpdateUserRatingInitialS extends UserRatingState {
  @override
  List<Object> get props => [];
}

class UpdateUserRatingSuccessS extends UserRatingState {
  final double userRating;

  const UpdateUserRatingSuccessS({required this.userRating});

  @override
  List<Object> get props => [userRating];
}
