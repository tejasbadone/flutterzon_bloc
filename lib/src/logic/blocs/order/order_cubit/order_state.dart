part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitialS extends OrderState {}

class OrderProcessS extends OrderState {
  final List<PaymentItem> paymentItems;
  final User user;

  const OrderProcessS({required this.paymentItems, required this.user});
  @override
  List<Object> get props => [paymentItems, user];
}

final class OrderErrorS extends OrderState {
  final String errorString;

  const OrderErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}

class DisableButtonS extends OrderState {}
