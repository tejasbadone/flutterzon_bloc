import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_bottom_bar_state.dart';

class AdminBottomBarCubit extends Cubit<AdminBottomBarState> {
  AdminBottomBarCubit() : super(const AdminBottomBarState(0));

  void adminBottomBar({required int index}) {
    emit(AdminBottomBarState(index));
  }
}
