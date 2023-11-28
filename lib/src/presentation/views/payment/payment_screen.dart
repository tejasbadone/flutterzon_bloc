import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/order/order_cubit/order_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

class PaymentScreen extends StatefulWidget {
  final String totalAmount;
  const PaymentScreen({super.key, required this.totalAmount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = '';

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().gPayButton(totalAmount: widget.totalAmount);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Constants.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'SubTotal ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  const Text(
                    '₹',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    formatPriceWithDecimal(double.parse(widget.totalAmount)),
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // if (address.isNotEmpty)
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderProcessS) {
                    return state.user.address == ''
                        ? const SizedBox()
                        : Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.user.address,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'OR',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: 'Flat, house no, building',
                      onChanged: (string) {
                        context
                            .read<OrderCubit>()
                            .addPaymentItem(totalAmount: widget.totalAmount);
                      },
                    ),
                    CustomTextfield(
                      controller: areaController,
                      hintText: 'Area, street',
                    ),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Town/city',
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) => snapshot.hasData
                      ? BlocConsumer<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state is OrderErrorS) {
                              showSnackBar(context, state.errorString);
                            }
                          },
                          builder: (context, state) {
                            if (state is OrderProcessS) {
                              return GooglePayButton(
                                onPressed: () {
                                  addressToBeUsed = '';
                                  bool isFromForm =
                                      flatBuildingController.text.isNotEmpty ||
                                          areaController.text.isNotEmpty ||
                                          pincodeController.text.isNotEmpty ||
                                          cityController.text.isNotEmpty;

                                  if (isFromForm) {
                                    if (_addressFormKey.currentState!
                                        .validate()) {
                                      addressToBeUsed =
                                          '${flatBuildingController.text}, ${areaController.text}, ${cityController.text}, ${pincodeController.text}';
                                    } else {
                                      throw Exception(
                                          'Please enter all the values');
                                    }
                                  } else if (addressToBeUsed.isEmpty) {
                                    addressToBeUsed = state.user.address;
                                  } else {
                                    showSnackBar(context, 'ERROR');
                                  }
                                },
                                width: double.infinity,
                                height: 50,
                                paymentConfiguration: snapshot.data!,
                                paymentItems: state.paymentItems,
                                type: GooglePayButtonType.order,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: (res) async {
                                  showSnackBar(context,
                                      'Order placed successfully! redirecting...');
                                  if (state.user.address == '') {
                                    context.read<UserCubit>().saveUserAddress(
                                        address: addressToBeUsed);
                                  }
                                  await context.read<OrderCubit>().placeOrder(
                                      address: addressToBeUsed,
                                      totalAmount:
                                          double.parse(widget.totalAmount));

                                  if (context.mounted) {
                                    context
                                        .read<CartBloc>()
                                        .add(GetCartPressed());
                                    Navigator.pop(context);
                                  }
                                },
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (state is DisableButtonS) {
                              return GPayDisabledButton(
                                  flatBuildingController:
                                      flatBuildingController,
                                  areaController: areaController,
                                  pincodeController: pincodeController,
                                  cityController: cityController,
                                  addressFormKey: _addressFormKey);
                            }

                            return GPayDisabledButton(
                                flatBuildingController: flatBuildingController,
                                areaController: areaController,
                                pincodeController: pincodeController,
                                cityController: cityController,
                                addressFormKey: _addressFormKey);
                          },
                        )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}

class GPayDisabledButton extends StatelessWidget {
  const GPayDisabledButton({
    super.key,
    required this.flatBuildingController,
    required this.areaController,
    required this.pincodeController,
    required this.cityController,
    required GlobalKey<FormState> addressFormKey,
  });

  final TextEditingController flatBuildingController;
  final TextEditingController areaController;
  final TextEditingController pincodeController;
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.grey.shade300,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      onPressed: () {
        showSnackBar(context, 'Please enter your address');
      },
      constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Order with ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            'assets/images/google_icon.png',
            height: 35,
            width: 35,
          ),
          const Text(
            'Pay',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
