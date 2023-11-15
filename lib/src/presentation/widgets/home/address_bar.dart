import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: const BoxDecoration(gradient: Constants.addressBarGradient),
      child: const Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Deliver to ',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          Icon(
            Icons.expand_more,
            size: 20,
          ),
        ],
      ),
    );
  }
}
