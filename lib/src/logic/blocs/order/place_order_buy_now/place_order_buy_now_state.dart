part of 'place_order_buy_now_cubit.dart';

sealed class PlaceOrderBuyNowState extends Equatable {
  const PlaceOrderBuyNowState();

  @override
  List<Object> get props => [];
}

final class PlaceOrderBuyNowInitialS extends PlaceOrderBuyNowState {}

class PlaceOrderBuyNowProcessS extends PlaceOrderBuyNowState {
  final List<PaymentItem> paymentItems;
  final User user;

  const PlaceOrderBuyNowProcessS(
      {required this.paymentItems, required this.user});
  @override
  List<Object> get props => [paymentItems, user];
}

final class PlaceOrderBuyNowErrorS extends PlaceOrderBuyNowState {
  final String errorString;

  const PlaceOrderBuyNowErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}

class PlaceOrderBuyNowDisableButtonS extends PlaceOrderBuyNowState {}
