import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_fetch_orders_state.dart';

class AdminFetchOrdersCubit extends Cubit<AdminFetchOrdersState> {
  final AdminRepository adminRepository;
  AdminFetchOrdersCubit(this.adminRepository)
      : super(AdminFetchOrdersLoadingS());

  void adminFetchOrders() async {
    try {
      List<Order> ordersList;
      List<Order> tempOrdersList;

      emit(AdminFetchOrdersLoadingS());

      tempOrdersList = await adminRepository.adminGetOrders();

      ordersList = tempOrdersList.reversed.toList();

      emit(AdminFetchOrdersSuccessS(ordersList: ordersList));
    } catch (e) {
      emit(AdminFetchOrdersErrorS(errorString: e.toString()));
    }
  }
}
