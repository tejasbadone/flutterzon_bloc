import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class KeepShoppingFor extends StatelessWidget {
  const KeepShoppingFor({
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
                'Keep shopping for',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, BrowsingHistory.routeName);
                  },
                  child: Text(
                    'Browsing history',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Constants.selectedNavBarColor),
                  ))
            ],
          ),
          // user.keepShoppingFor.isEmpty
          // ? const SizedBox()
          // :
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 15,
                childAspectRatio:
                    //  user.keepShoppingFor.length == 1
                    //     ? 2.0
                    //     : user.keepShoppingFor.length == 3
                    //         ? 0.7
                    //         :
                    1.15,
                crossAxisCount:
                    //  user.keepShoppingFor.length >= 4
                    // ?
                    2
                // : user.keepShoppingFor.length,
                ),
            itemCount:
                //  user.keepShoppingFor.length >= 4
                // ?
                4,
            // : user.keepShoppingFor.length,
            itemBuilder: (context, index) {
              // if (user.wishList.length >= 4) {
              //   index =
              //       getUniqueRandomInt(max: user.keepShoppingFor.length);
              // }

              return InkWell(
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, CategoryDealsScreen.routeName,
                  //     arguments: user.keepShoppingFor[index]['product']
                  //         ['category'],
                  // );
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
                        imageUrl:
                            'https://res.cloudinary.com/dthljz11q/image/upload/v1698516160/OnePlus%2011R%205G%20%28Galactic%20Silver%2C%208GB%20RAM%2C%20128GB%20Storage%29/rllsp9kvyuzvomw8ylgl.jpg'

                        // user.keepShoppingFor[index]['product']
                        //     ['images'][0]
                        ,
                        height: 90,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '  user.keepShoppingFor[index]',
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
