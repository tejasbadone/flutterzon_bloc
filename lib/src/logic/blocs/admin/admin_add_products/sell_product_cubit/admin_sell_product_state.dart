part of 'admin_sell_product_cubit.dart';

sealed class AdminSellProductState extends Equatable {
  const AdminSellProductState();

  @override
  List<Object> get props => [];
}

final class AdminSellProductInitial extends AdminSellProductState {}

final class AdminSellProductsLoadingS extends AdminSellProductState {}

final class AdminSellProductSuccessS extends AdminSellProductState {
  @override
  List<Object> get props => [];
}

final class AdminSellProductErrorS extends AdminSellProductState {
  final String errorString;

  const AdminSellProductErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
