import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class ShipmentStatus extends StatelessWidget {
  const ShipmentStatus({
    super.key,
    required this.currentStep,
    required this.textStyle,
  });

  final int currentStep;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        currentStep == 0
            ? Text(
                'In Process',
                style: textStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Constants.greenColor),
              )
            : currentStep == 1
                ? Text(
                    'Received',
                    style: textStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Constants.greenColor),
                  )
                : currentStep == 2
                    ? Text(
                        'Dispatched',
                        style: textStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Constants.greenColor),
                      )
                    : currentStep == 3
                        ? Text(
                            'In Transit',
                            style: textStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Constants.greenColor),
                          )
                        : Text(
                            'Delivered',
                            style: textStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Constants.greenColor),
                          ),
      ],
    );
  }
}
