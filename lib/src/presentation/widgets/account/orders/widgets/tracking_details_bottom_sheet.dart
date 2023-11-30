import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_change_order_status/admin_change_order_status_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingDetailsBottomSheet extends StatelessWidget {
  const TrackingDetailsBottomSheet({
    super.key,
    required this.order,
    required this.user,
  });

  final Order order;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery by Amazon',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          Text(
            ' Order ID: ${order.id}',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
          BlocConsumer<AdminChangeOrderStatusCubit,
              AdminChangeOrderStatusState>(
            listener: (context, state) {
              if (state is AdminChangeOrderStatusErrorS) {
                showSnackBar(context, state.errorString);
              }
            },
            builder: (context, state) {
              if (state is AdminChangeOrderStatusSuccessS) {
                return StepperWidget(
                    currentStep: state.status, user: user, order: order);
              }
              return StepperWidget(
                  currentStep: order.status, user: user, order: order);
            },
          ),
        ],
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    super.key,
    required this.currentStep,
    required this.user,
    required this.order,
  });

  final int currentStep;
  final User user;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stepper(
          physics: const NeverScrollableScrollPhysics(),
          currentStep: currentStep,
          controlsBuilder: ((context, details) {
            if (user.type == 'admin') {
              return CustomElevatedButton(
                  buttonText: 'Done',
                  onPressed: () {
                    context
                        .read<AdminChangeOrderStatusCubit>()
                        .adminChangeOrderStatus(
                            orderId: order.id, status: order.status + 1);
                  });
            }
            return const SizedBox();
          }),
          steps: [
            Step(
              title: const Text('Received'),
              content: const Text(
                  'Your order has been received and is currently being processed by the seller.'),
              isActive: currentStep > 0,
              state: currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text('Dispatched'),
              content:
                  const Text('Your order has been shipped and dispatched.'),
              isActive: currentStep > 1,
              state: currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text('In Transit'),
              content: const Text('Your order is currently in transit.'),
              isActive: currentStep > 2,
              state: currentStep > 2 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text('Delivered'),
              content: const Text('Your order has been delivered.'),
              isActive: currentStep > 3,
              state: currentStep > 3 ? StepState.complete : StepState.indexed,
            ),
          ]),
    );
  }
}
