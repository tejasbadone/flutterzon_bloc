import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().currentUser!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: const BoxDecoration(gradient: Constants.addressBarGradient),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Deliver to ${user.address}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          const Icon(
            Icons.expand_more,
            size: 20,
          ),
        ],
      ),
    );
  }
}
