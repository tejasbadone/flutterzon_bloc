part of 'fetch_orders_cubit.dart';

sealed class FetchOrdersState extends Equatable {
  const FetchOrdersState();

  @override
  List<Object> get props => [];
}

final class FetchOrdersLoadingS extends FetchOrdersState {}

final class FetchOrdersSuccessS extends FetchOrdersState {
  final List<Order> ordersList;

  const FetchOrdersSuccessS({required this.ordersList});

  @override
  List<Object> get props => [ordersList];
}

final class FetchOrdersErrorS extends FetchOrdersState {
  final String errorString;

  const FetchOrdersErrorS({required this.errorString});
}
