import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'fetch_ordres_state.dart';

class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  final AccountRepository accountRepository;

  FetchOrdersCubit(this.accountRepository) : super(FetchOrdersLoadingAS());

  void fetchOrders() async {
    try {
      List<Order> tempOrdersList;
      List<Order> ordersList;

      emit(FetchOrdersLoadingAS());

      tempOrdersList = await accountRepository.fetchMyOrders();
      ordersList = tempOrdersList.reversed.toList();

      emit(FetchOrdersSuccessAS(ordersList: ordersList));
    } catch (e) {
      emit(FetchOrdersErrorAS(errorString: e.toString()));
    }
  }

  void fetchSearchedOrders(String orderQuery) async {
    try {
      List<Order> searchedOrdersList;

      emit(FetchSearchedOrdersLoadingS());

      searchedOrdersList =
          await accountRepository.fetchsearchedOrders(orderQuery);

      emit(FetchSearchedOrdersSuccessS(searchedOrdersList: searchedOrdersList));
    } catch (e) {
      emit(FetchOrdersErrorAS(errorString: e.toString()));
    }
  }
}
