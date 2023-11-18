import 'package:flutter/material.dart';

class DividerWithSizedBox extends StatelessWidget {
  const DividerWithSizedBox({
    super.key,
    this.sB1Height = 8,
    this.sB2Height = 8,
    this.thickness = 2,
  });

  final double sB1Height;
  final double sB2Height;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: sB1Height),
        Divider(
          color: const Color(0xffD5D9DA),
          thickness: thickness,
        ),
        SizedBox(height: sB2Height),
      ],
    );
  }
}
