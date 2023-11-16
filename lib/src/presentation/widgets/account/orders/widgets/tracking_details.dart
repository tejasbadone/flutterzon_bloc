import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_elevated_button.dart';

class TrackingDetails extends StatefulWidget {
  const TrackingDetails({
    super.key,
    required this.order,
  });

  final Border order;

  @override
  State<TrackingDetails> createState() => _TrackingDetailsState();
}

class _TrackingDetailsState extends State<TrackingDetails> {
  // final AdminServices adminServices = AdminServices();
  int currentStep = 0;

  // void changeOrderStatus(int status) {
  //   adminServices.changeOrderStatus(
  //       context: context,
  //       order: widget.order,
  //       status: status + 1,
  //       onSuccess: () {
  //         setState(() {
  //           currentStep += 1;
  //         });
  //       });
  //   debugPrint('onPressed clicked!');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   currentStep = widget.order.status;
  // }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context, listen: false).user;

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
          const Text(
            ' Order ID: {widget.order.id',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
          SizedBox(
            width: double.infinity,
            child: Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: currentStep,
                controlsBuilder: ((context, details) {
                  // if (user.type == 'admin') {
                  return CustomElevatedButton(
                      buttonText: 'Done', onPressed: () {}

                      // changeOrderStatus(details.currentStep)
                      );
                  // }
                  return const SizedBox();
                }),
                steps: [
                  Step(
                    title: const Text('Received'),
                    content: const Text(
                        'Your order has been received and is currently being processed by the seller.'),
                    isActive: currentStep > 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Dispatched'),
                    content: const Text(
                        'Your order has been shipped and dispatched.'),
                    isActive: currentStep > 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('In Transit'),
                    content: const Text('Your order is currently in transit.'),
                    isActive: currentStep > 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Delivered'),
                    content: const Text('Your order has been delivered.'),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
