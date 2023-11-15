import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/bottom_bar/pay_containers.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final List<File>? photos = [];

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) {
            photos!.add(file);
            Navigator.pop(context);
            setState(
              () {},
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            'Do more with Amazon',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => openCamera(),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xffE9EDEE),
                  border:
                      Border.all(color: const Color(0xffD6DADB), width: 0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.center_focus_strong_outlined,
                    size: 50,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tap here to enable your camera',
                    style: TextStyle(
                        fontSize: 12, color: Constants.selectedNavBarColor),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xffE2EFE8),
                border: Border.all(color: const Color(0xffD6DADB), width: 0.5),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: const Text(
              'Scan any QR to Pay',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              PayContainers(
                  imagepath: 'assets/images/bottom_offers/amazon_pay.png',
                  belowText: 'Pay Bills, Send Money & more',
                  onPressedString: 'Amazon Pay'),
              SizedBox(width: 10),
              PayContainers(
                  imagepath: 'assets/images/minitv.png',
                  belowText: 'Watch Free Web Series & Shows',
                  onPressedString: 'Amazon MiniTV'),
            ],
          )
        ],
      ),
    );
  }
}
