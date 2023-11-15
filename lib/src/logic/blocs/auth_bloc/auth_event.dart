part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class TextFieldChangedEvent extends AuthEvent {
  final String nameValue;
  final String emailValue;
  final String passwordValue;

  TextFieldChangedEvent(this.nameValue, this.emailValue, this.passwordValue);
}

class CreateAccountPressedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  CreateAccountPressedEvent(this.name, this.email, this.password);
}

class SignInPressedEvent extends AuthEvent {
  final String email;
  final String password;

  SignInPressedEvent(this.email, this.password);
}
