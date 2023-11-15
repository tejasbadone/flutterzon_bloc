part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

// textfield states
final class TextFieldChangedState extends AuthState {
  final String emailValue;
  final String passwordValue;

  TextFieldChangedState(this.emailValue, this.passwordValue);
}

final class TextFieldErrorState extends AuthState {
  final String errorString;

  TextFieldErrorState({required this.errorString});
}

final class TextFieldValidState extends AuthState {
  final String emailValue;
  final String passwordValue;

  TextFieldValidState({required this.emailValue, required this.passwordValue});
}

// Create user states
final class CreateUserInProgressState extends AuthState {
  final User user;

  CreateUserInProgressState({required this.user});
}

final class CreateUserSuccessState extends AuthState {
  final String userCreatedString;
  CreateUserSuccessState({required this.userCreatedString});
}

final class CreateUserErrorState extends AuthState {
  final String errorString;
  CreateUserErrorState({required this.errorString});
}

// sign in user states
final class SignInSuccessState extends AuthState {
  final User user;

  SignInSuccessState({required this.user});
}

final class SignInErrorState extends AuthState {
  final String errorString;

  SignInErrorState({required this.errorString});
}

final class AuthErrorState extends AuthState {
  final String errorString;

  AuthErrorState({required this.errorString});
}
