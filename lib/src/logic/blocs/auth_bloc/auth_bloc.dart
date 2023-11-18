// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<TextFieldChangedEvent>(_onTextFieldChangedHandler);
    on<CreateAccountPressedEvent>(_onCreateAccountPressedHandler);
    on<SignInPressedEvent>(_signInPressedhandler);
  }

  void _onTextFieldChangedHandler(
      TextFieldChangedEvent event, Emitter<AuthState> emit) {
    if (event.nameValue == '') {
      emit(
          TextFieldErrorState(errorString: 'First and last name is required.'));
    } else if (event.emailValue == '') {
      emit(TextFieldErrorState(
          errorString: 'Please enter a valid email address.'));
    } else if (event.passwordValue.length < 6) {
      emit(TextFieldErrorState(
          errorString: 'Passwords must be at least 6 characters.'));
    } else {
      emit(TextFieldValidState(
          emailValue: event.emailValue, passwordValue: event.passwordValue));
    }
  }

  void _onCreateAccountPressedHandler(event, emit) async {
    emit(AuthLoadingState());
    User user = User(
      id: '',
      name: event.name,
      email: event.email,
      password: event.password,
      address: '',
      type: '',
      token: '',
      cart: const [],
      saveForLater: const [],
      keepShoppingFor: const [],
      wishList: const [],
    );

    try {
      User resUser = await authRepository.singUpUser(user);

      emit(CreateUserInProgressState(user: resUser));

      emit(CreateUserSuccessState(
          userCreatedString: 'User Created, you can sign in now!'));
    } catch (e) {
      emit(AuthErrorState(errorString: e.toString()));
    }
  }

  void _signInPressedhandler(event, emit) async {
    emit(AuthLoadingState());

    try {
      User user = await authRepository.signInUser(event.email, event.password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', user.token);

      emit(UpdateUserData(user: user));

      emit(SignInSuccessState(user: user));
    } catch (e) {
      emit(AuthErrorState(errorString: e.toString()));
    }
  }
}
