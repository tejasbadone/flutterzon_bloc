import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_change_order_status_state.dart';

class AdminChangeOrderStatusCubit extends Cubit<AdminChangeOrderStatusState> {
  final AdminRepository adminRepository;
  AdminChangeOrderStatusCubit(this.adminRepository)
      : super(AdminChangeOrderStatusInitialS());

  Future<void> adminChangeOrderStatus(
      {required String orderId, required int status}) async {
    try {
      int resStatus;

      resStatus = await adminRepository.adminChangeOrderStatus(
          orderId: orderId, status: status);

      emit(AdminChangeOrderStatusSuccessS(status: resStatus));
    } catch (e) {
      emit(AdminChangeOrderStatusErrorS(errorString: e.toString()));
      log(e.toString());
    }
  }
}
