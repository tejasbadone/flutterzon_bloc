import 'package:flutter/material.dart';

class CustomIconbutton extends StatelessWidget {
  const CustomIconbutton({
    super.key,
    required this.iconName,
    required this.isRight,
  });

  final IconData iconName;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: isRight
            ? const BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8))
            : const BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffF7F8FA), Color(0xffE8E9ED)],
            stops: [0.2, 1]),
      ),
      child: Icon(
        iconName,
        size: 18,
        color: Colors.black,
      ),
    );
  }
}
