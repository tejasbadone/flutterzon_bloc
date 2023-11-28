import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:pay/pay.dart';

part 'place_order_buy_now_state.dart';

class PlaceOrderBuyNowCubit extends Cubit<PlaceOrderBuyNowState> {
  final UserRepository userRepository;
  PlaceOrderBuyNowCubit(this.userRepository)
      : super(PlaceOrderBuyNowInitialS());

  void addPaymentItem({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];
      User user;

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      user = await userRepository.getUserData();

      emit(PlaceOrderBuyNowProcessS(paymentItems: paymentItemList, user: user));
    } catch (e) {
      emit(PlaceOrderBuyNowErrorS(errorString: e.toString()));
    }
  }

  void gPayButton({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];
      User user;

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      user = await userRepository.getUserData();

      if (user.address == '') {
        emit(PlaceOrderBuyNowDisableButtonS());
      } else {
        emit(PlaceOrderBuyNowProcessS(
            paymentItems: paymentItemList, user: user));
      }
    } catch (e) {
      emit(PlaceOrderBuyNowErrorS(errorString: e.toString()));
    }
  }

  Future<User> getUserData() async {
    User user;

    user = await userRepository.getUserData();

    return user;
  }

  void placeOrderBuyNow(
      {required Product product, required String address}) async {
    try {
      await userRepository.placeOrderBuyNow(product: product, address: address);
    } catch (e) {
      emit(PlaceOrderBuyNowErrorS(errorString: e.toString()));
    }
  }
}
