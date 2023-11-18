part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitialS extends UserState {}

final class UserLoadingS extends UserState {}

final class UserSuccessS extends UserState {
  final User user;

  const UserSuccessS({required this.user});

  @override
  List<Object> get props => [user];
}

final class UserErrorS extends UserState {
  final String errorString;

  const UserErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
