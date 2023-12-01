import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/four-images-offer/admin_four_image_offer_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/divider_with_sizedbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminFourImagesOffer extends StatelessWidget {
  const AdminFourImagesOffer({
    super.key,
    required this.title,
    required this.offerId,
    required this.images,
    required this.labels,
    required this.category,
  });

  final String offerId;
  final String title;
  final List<String> labels;
  final List<String> images;
  final String category;

  @override
  Widget build(BuildContext context) {
    void goToCateogryDealsScreen() {
      context.pushNamed(AppRouteConstants.categoryproductsScreenRoute.name,
          pathParameters: {'category': category});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          // height: 500,
          decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.6),
              borderRadius: BorderRadius.circular(5)),
          // width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 460,
                child: GridView.builder(
                  itemCount: images.length,
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
                                  imageUrl: images[index],
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
                                labels[index],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)),
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<AdminFourImageOfferCubit>()
                            .adminDeleteFourImagesOffer(offerId: offerId);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 26,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
              const DividerWithSizedBox(
                sB2Height: 0,
                thickness: 0.7,
              )
            ],
          ),
        ),
      ],
    );
  }
}
