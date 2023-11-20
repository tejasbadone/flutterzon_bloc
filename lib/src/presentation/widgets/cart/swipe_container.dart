import 'package:flutter/material.dart';

class SwipeContainer extends StatelessWidget {
  const SwipeContainer({
    super.key,
    required this.isDelete,
    required this.secondaryBackgroundText,
  });

  final bool isDelete;
  final String secondaryBackgroundText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDelete ? const Color(0xffC40202) : const Color(0xffE3E5E4),
      child: Row(
        children: [
          SizedBox(
            width: isDelete ? 50 : 250,
          ),
          Text(
            isDelete ? 'Delete' : secondaryBackgroundText,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDelete ? Colors.white : Colors.black87),
          ),
        ],
      ),
    );
  }
}
