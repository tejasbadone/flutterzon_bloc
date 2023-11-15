import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class WishList extends StatelessWidget {
  const WishList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Wish List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, WishListScreen.routeName);
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Constants.selectedNavBarColor),
                  ))
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 15,
                childAspectRatio: 1.15,
                // user.wishList.length == 1
                //     ? 2.0
                //     : user.wishList.length == 3
                //         ? 0.7
                //         : 1.15,
                crossAxisCount: 2

                // user.wishList.length >= 4 ? 2 : user.wishList.length,
                ),
            itemCount: 2,
            // user.wishList.length >= 4 ? 4 : user.wishList.length,
            itemBuilder: (context, index) {
              // if (user.wishList.length >= 6) {
              //   index = getUniqueRandomInt(max: user.wishList.length);
              // }
              return InkWell(
                onTap: () {
                  // Map<String, dynamic> arguments = {
                  //   'product':
                  //       Product.fromMap(user.wishList[index]['product']),
                  //   'deliveryDate': getDeliveryDate(),
                  // };

                  // Navigator.pushNamed(
                  //     context, ProductDetailsScreen.routeName,
                  //     arguments: arguments);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'null',

                        // user.wishList[index]['product']
                        //     ['images'][0],
                        height: 110,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '  {user.wishList[index]["product"]["name"]}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
