part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoadingState extends AuthState {}

// textfield states
final class TextFieldChangedState extends AuthState {
  final String emailValue;
  final String passwordValue;

  TextFieldChangedState(this.emailValue, this.passwordValue);
  @override
  List<Object?> get props => [emailValue, passwordValue];
}

final class TextFieldErrorState extends AuthState {
  final String errorString;

  TextFieldErrorState({required this.errorString});
  @override
  List<Object?> get props => [errorString];
}

final class TextFieldValidState extends AuthState {
  final String emailValue;
  final String passwordValue;

  TextFieldValidState({required this.emailValue, required this.passwordValue});
  @override
  List<Object?> get props => [emailValue, passwordValue];
}

// Create user states
final class CreateUserInProgressState extends AuthState {
  final User user;

  CreateUserInProgressState({required this.user});
  @override
  List<Object?> get props => [user];
}

final class CreateUserSuccessState extends AuthState {
  final String userCreatedString;
  CreateUserSuccessState({required this.userCreatedString});
  @override
  List<Object?> get props => [userCreatedString];
}

final class CreateUserErrorState extends AuthState {
  final String errorString;
  CreateUserErrorState({required this.errorString});
  @override
  List<Object?> get props => [errorString];
}

// sign in user states
final class SignInSuccessState extends AuthState {
  final User user;

  SignInSuccessState({required this.user});
  @override
  List<Object?> get props => [user];
}

final class SignInErrorState extends AuthState {
  final String errorString;

  SignInErrorState({required this.errorString});
  @override
  List<Object?> get props => [errorString];
}

final class AuthErrorState extends AuthState {
  final String errorString;

  AuthErrorState({required this.errorString});
  @override
  List<Object?> get props => [errorString];
}

// update user data
final class UpdateUserData extends AuthState {
  final User user;

  UpdateUserData({required this.user});
  @override
  List<Object?> get props => [user];
}
