import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> with HydratedMixin {
  UserCubit() : super(UserInitialS());

  void setUser(User user) {
    emit(UserLoadingS());
    try {
      saveToStorage(user);

      emit(UserSuccessS(user: user.copyWith()));
    } catch (e) {
      emit(UserErrorS(errorString: e.toString()));
    }
  }
  // }
// { String? id, String? name, String? email, String? password, String? address, String? type, String? token, List<dynamic>? cart, List<dynamic>?  saveForLater, List<dynamic>? keepShoppingFor,List<dynamic>? wishList }

  void updateUser(User updatedUser) {
    emit(UserLoadingS());
    try {
      saveToStorage(updatedUser);

      emit(UserSuccessS(user: updatedUser.copyWith()));
    } catch (e) {
      emit(UserErrorS(errorString: e.toString()));
    }
  }

  // void updateUser(
  //     {String? id,
  //     String? name,
  //     String? email,
  //     String? password,
  //     String? address,
  //     String? type,
  //     String? token,
  //     List<dynamic>? cart,
  //     List<dynamic>? saveForLater,
  //     List<dynamic>? keepShoppingFor,
  //     List<dynamic>? wishList}) {
  //   emit(UserLoadingS());
  //   try {
  //     // if (state is UserSuccessS) {
  //     User updatedUser = (state as UserSuccessS).user.copyWith(
  //           id: id,
  //           name: name,
  //           email: email,
  //           password: password,
  //           address: address,
  //           type: type,
  //           token: token,
  //           cart: cart,
  //           saveForLater: saveForLater,
  //           keepShoppingFor: keepShoppingFor,
  //           wishList: wishList,
  //         );
  //     saveToStorage(updatedUser);

  //     emit(UserSuccessS(user: updatedUser.copyWith()));
  //     // } else {
  //     // }
  //   } catch (e) {
  //     print(
  //         'error in updateUser copywith method, instead of one one property, pass the whole usermodel like before');
  //     emit(UserErrorS(errorString: e.toString()));
  //   }
  // }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json['user']);
      return UserSuccessS(user: user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //   if (json['user'] != null) {
  //     return UserSuccessS(user: User.fromJson(json['user']));
  //   } else {
  //     return UserInitialS();
  //   }
  // }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserSuccessS) {
      return {'user': state.user.toJson()};
    } else {
      return {};
    }
  }

  void saveToStorage(User updatedUser) async {
    await HydratedBloc.storage
        .write('user_data', updatedUser.copyWith().toJson());
  }
}
