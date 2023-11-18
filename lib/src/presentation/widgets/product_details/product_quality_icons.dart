import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class ProductQualityIcons extends StatelessWidget {
  const ProductQualityIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: Constants.productQualityDetails.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            final iconMapPath =
                Constants.productQualityDetails[index]['iconName']!;
            final titleMapPath =
                Constants.productQualityDetails[index]['title']!;
            return SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/product_quality_icons/$iconMapPath',
                    height: 45,
                    width: 45,
                  ),
                  Text(
                    titleMapPath,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        letterSpacing: 0,
                        height: 0,
                        wordSpacing: 0,
                        color: Constants.selectedNavBarColor,
                        fontSize: 14),
                  )
                ],
              ),
            );
          })),
    );
  }
}
