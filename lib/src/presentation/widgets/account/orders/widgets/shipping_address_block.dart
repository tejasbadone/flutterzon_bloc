import 'package:flutter/material.dart';

class ShippingAddressBlock extends StatelessWidget {
  const ShippingAddressBlock({
    super.key,
    required this.headingTextSyle,
    required this.containerDecoration,
    // required this.user,
    required this.textSyle,
  });

  final TextStyle headingTextSyle;
  final BoxDecoration containerDecoration;
  // final User user;
  final TextStyle textSyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping Address', style: headingTextSyle),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: containerDecoration,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'user.name',
              style: textSyle.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'user.address',
              style: textSyle.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
