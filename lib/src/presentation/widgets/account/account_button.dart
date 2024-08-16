import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class AccountButton extends StatelessWidget {
  const AccountButton(
      {super.key, required this.buttonName, required this.onPressed});

  final String buttonName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStatePropertyAll(Colors.grey.shade100),
                backgroundColor: WidgetStatePropertyAll(
                    Colors.grey.shade100.withOpacity(0.40)),
                side: const WidgetStatePropertyAll(
                    BorderSide(color: Constants.greyBackgroundColor))),
            child: Text(
              buttonName,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 15),
            )),
      ),
    );
  }
}
