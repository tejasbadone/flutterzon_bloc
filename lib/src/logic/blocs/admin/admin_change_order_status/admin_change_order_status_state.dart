part of 'admin_change_order_status_cubit.dart';

sealed class AdminChangeOrderStatusState extends Equatable {
  const AdminChangeOrderStatusState();

  @override
  List<Object> get props => [];
}

final class AdminChangeOrderStatusInitialS
    extends AdminChangeOrderStatusState {}

final class AdminChangeOrderStatusSuccessS extends AdminChangeOrderStatusState {
  final int status;

  const AdminChangeOrderStatusSuccessS({required this.status});

  @override
  List<Object> get props => [status];
}

final class AdminChangeOrderStatusErrorS extends AdminChangeOrderStatusState {
  final String errorString;

  const AdminChangeOrderStatusErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
