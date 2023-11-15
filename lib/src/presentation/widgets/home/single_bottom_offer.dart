import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/single_top_category_item.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class SingleBottomOffer extends StatelessWidget {
  const SingleBottomOffer({
    super.key,
    required this.mapName,
  });

  final dynamic mapName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      width: 150,
      decoration: BoxDecoration(
        gradient: Constants.goldenGradient,
        borderRadius: BorderRadius.circular(4),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 85, crossAxisCount: 2),
        itemBuilder: (context, index) {
          return SingleTopCategoryItem(
            image: mapName[index]['image']!,
            title: mapName[index]['title']!,
            isBottomOffer: true,
          );
        },
      ),
    );
  }
}
