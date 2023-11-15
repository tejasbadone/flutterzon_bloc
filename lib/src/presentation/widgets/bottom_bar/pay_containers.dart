import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class PayContainers extends StatelessWidget {
  const PayContainers({
    super.key,
    required this.imagepath,
    required this.belowText,
    required this.onPressedString,
  });

  final String imagepath;
  final String belowText;
  final String onPressedString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (context.mounted) {
            showSnackBar(context, '$onPressedString coming soon!');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3), // Adjust shadow offset
                blurRadius: 3, // Adjust blur radius
                spreadRadius: 0, // Adjust spread radius
              ),
            ],
            color: const Color(0xffF6FAFB),
            border: Border.all(color: const Color(0xffD6DADB), width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Image.asset(imagepath, height: 45),
              const SizedBox(
                height: 10,
              ),
              Text(
                belowText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }
}
