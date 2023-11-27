import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/auth_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'page_redirection_state.dart';

class PageRedirectionCubit extends Cubit<PageRedirectionState> {
  final AuthRepository authRepository;
  UserRepository userRepository = UserRepository();
  PageRedirectionCubit(this.authRepository) : super(PageRedirectionInitial());

  Future<List<dynamic>> redirectUser() async {
    bool isValid;
    String userType;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      isValid = await authRepository.isTokenValid(token: token);

      if (isValid == true) {
        User user = await userRepository.getUserDataInitial(token);
        userType = user.type;
        return [isValid, userType];
      } else {
        return [isValid, ''];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
