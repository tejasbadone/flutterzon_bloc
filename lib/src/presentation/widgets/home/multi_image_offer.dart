import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:go_router/go_router.dart';

class MultiImageOffer extends StatelessWidget {
  const MultiImageOffer({
    super.key,
    required this.headtitle,
    required this.subTitle,
    required this.mapName,
    required this.productCategory,
  });

  final List<Map<String, String>> mapName;
  final String headtitle;
  final String subTitle;
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    void goToCateogryDealsScreen() {
      context.pushNamed(AppRouteConstants.categoryproductsScreenRoute.name,
          pathParameters: {'category': productCategory});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headtitle,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 14),
              ),
            ],
          ),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          // width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 460,
                child: GridView.builder(
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 230, crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () => goToCateogryDealsScreen(),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: mapName[index]['image']!,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.sizeOf(context).width,
                                  height: MediaQuery.sizeOf(context).height,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                mapName[index]['offerTitle']!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 8),
                child: GestureDetector(
                  onTap: () => goToCateogryDealsScreen(),
                  child: Text(
                    'See all offers',
                    style: TextStyle(color: Constants.selectedNavBarColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
