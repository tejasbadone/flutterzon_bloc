part of 'fethc_orders_cubit.dart';

sealed class FetchOrdersState extends Equatable {
  const FetchOrdersState();

  @override
  List<Object> get props => [];
}

// Fetch Orders
final class FetchOrdersLoadingAS extends FetchOrdersState {
  @override
  List<Object> get props => [];
}

final class FetchOrdersSuccessAS extends FetchOrdersState {
  final List<Order> ordersList;

  const FetchOrdersSuccessAS({required this.ordersList});

  @override
  List<Object> get props => [ordersList];
}

final class FetchOrdersErrorAS extends FetchOrdersState {
  final String errorString;

  const FetchOrdersErrorAS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}

//Fetch searched orders

class FetchSearchedOrdersLoadingS extends FetchOrdersState {
  @override
  List<Object> get props => [];
}

class FetchSearchedOrdersSuccessS extends FetchOrdersState {
  final List<Order> searchedOrdersList;

  const FetchSearchedOrdersSuccessS({
    required this.searchedOrdersList,
  });

  @override
  List<Object> get props => [searchedOrdersList];
}

class FetchSearchedOrdersErrorS extends FetchOrdersState {
  final String errorString;

  const FetchSearchedOrdersErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
