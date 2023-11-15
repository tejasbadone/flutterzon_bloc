import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final void Function(String)? onChanged;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          // constraints: const BoxConstraints(minHeight: 70, maxHeight: 70),
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.w400),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
