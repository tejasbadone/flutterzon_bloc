part of 'radio_bloc.dart';

sealed class RadioState extends Equatable {
  const RadioState();

  @override
  List<Object> get props => [];
}

final class RadioInitial extends RadioState {}

// ratio
final class RadioSignUpState extends RadioState {
  final Auth auth;

  const RadioSignUpState({required this.auth});

  @override
  List<Object> get props => [auth];
}

final class RadioSignInState extends RadioState {
  final Auth auth;

  const RadioSignInState({required this.auth});

  @override
  List<Object> get props => [auth];
}
