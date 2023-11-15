import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.isMenuScreenButton = false});

  final String buttonText;
  final VoidCallback onPressed;
  final bool isMenuScreenButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xffD5D9DA),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            isMenuScreenButton
                ? const BoxShadow()
                : BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
          ],
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: isMenuScreenButton ? 14 : 13,
              fontWeight: FontWeight.w400,
              color: Colors.black87),
        ),
      ),
    );
  }
}
