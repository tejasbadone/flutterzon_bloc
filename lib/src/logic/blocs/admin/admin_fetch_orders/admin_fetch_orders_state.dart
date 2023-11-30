part of 'admin_fetch_orders_cubit.dart';

sealed class AdminFetchOrdersState extends Equatable {
  const AdminFetchOrdersState();

  @override
  List<Object> get props => [];
}

final class AdminFetchOrdersLoadingS extends AdminFetchOrdersState {}

final class AdminFetchOrdersSuccessS extends AdminFetchOrdersState {
  final List<Order> ordersList;

  const AdminFetchOrdersSuccessS({required this.ordersList});

  @override
  List<Object> get props => [ordersList];
}

final class AdminFetchOrdersErrorS extends AdminFetchOrdersState {
  final String errorString;

  const AdminFetchOrdersErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
