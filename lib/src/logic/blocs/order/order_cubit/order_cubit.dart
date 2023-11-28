import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:pay/pay.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserRepository userRepository;
  OrderCubit(this.userRepository) : super(OrderInitialS());

  void addPaymentItem({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];
      User user;

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      user = await userRepository.getUserData();

      emit(OrderProcessS(paymentItems: paymentItemList, user: user));
    } catch (e) {
      emit(OrderErrorS(errorString: e.toString()));
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
        emit(DisableButtonS());
      } else {
        emit(OrderProcessS(paymentItems: paymentItemList, user: user));
      }
    } catch (e) {
      emit(OrderErrorS(errorString: e.toString()));
    }
  }

  Future<User> getUserData() async {
    User user;

    user = await userRepository.getUserData();

    return user;
  }

  Future<void> placeOrder(
      {required String address, required double totalAmount}) async {
    try {
      await userRepository.placeOrder(
          totalPrice: totalAmount, address: address);
    } catch (e) {
      emit(OrderErrorS(errorString: e.toString()));
    }
  }
}
