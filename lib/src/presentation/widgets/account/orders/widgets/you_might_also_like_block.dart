import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/you_might_also_like_single.dart';

class YouMightAlsoLikeBlock extends StatelessWidget {
  const YouMightAlsoLikeBlock({
    super.key,
    required this.headingTextSyle,
  });

  final TextStyle headingTextSyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You might also like',
          style: headingTextSyle,
        ),
        const SizedBox(
          height: 10,
        ),
        // categoryProductList == null
        //     ? const Center(child: CircularProgressIndicator())
        //     : SizedBox(
        //         height: 250,
        //         child: ListView.builder(
        //             itemCount: categoryProductList!.length,
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: ((context, index) {
        //               Product productData = categoryProductList![index];
        //               return categoryProductList == null
        //                   ? const Center(child: CircularProgressIndicator())
        //                   : InkWell(
        //                       onTap: () {
        //                         // navigateToProductDetails(
        //                         //     context: context,
        //                         //     product: productData,
        //                         //     deliveryDate: 'Null for now');
        //                       },
        //                       child:
        //                           YouMightAlsoLikeSingle(product: productData));
        //             })),
        //       )
      ],
    );
  }
}
