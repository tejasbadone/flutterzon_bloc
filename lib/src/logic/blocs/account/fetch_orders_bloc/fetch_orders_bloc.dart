import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'fetch_orders_event.dart';
part 'fetch_orders_state.dart';

class FetchOrdersBloc extends Bloc<FetchOrdersEvent, FetchOrdersState> {
  final AccountRepository accountRepository;

  FetchOrdersBloc(this.accountRepository) : super(FetchOrdersLoadingS()) {
    on<FetchOrdersEvent>(_fetchOrderHandler);
    on<FetchSearchedOrdersEvent>(_fetchSearchedOrdersHandler);
  }

  void _fetchOrderHandler(event, emit) async {
    try {
      List<Order> ordersList;

      emit(FetchOrdersLoadingS());

      ordersList = await accountRepository.fetchMyOrders();

      ordersList.reversed.toList();

      emit(FetchOrdersSuccessS(ordersList: ordersList));
    } catch (e) {
      emit(FetchOrdersErrorS(errorString: e.toString()));
    }
  }

  void _fetchSearchedOrdersHandler(event, emit) async {
    try {
      List<Order> searchedOrdersList;

      emit(FetchOrdersLoadingS());

      searchedOrdersList =
          await accountRepository.fetchsearchedOrders(event.orderQuery);

      searchedOrdersList.reversed.toList();

      emit(FetchOrdersSuccessS(ordersList: searchedOrdersList));
    } catch (e) {
      emit(FetchOrdersErrorS(errorString: e.toString()));
    }
  }
}
