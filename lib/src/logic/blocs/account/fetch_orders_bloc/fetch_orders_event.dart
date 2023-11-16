part of 'fetch_orders_bloc.dart';

sealed class FetchOrdersEvent extends Equatable {
  const FetchOrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchAccountOrdersEvent extends FetchOrdersEvent {
  const FetchAccountOrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchedOrdersEvent extends FetchOrdersEvent {
  final String orderQuery;

  const FetchSearchedOrdersEvent({required this.orderQuery});

  @override
  List<Object> get props => [orderQuery];
}
