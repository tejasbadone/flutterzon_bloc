import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/deal_of_the_day/deal_of_the_day_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DealOfTheDayCubit>().getDealOfTheDay(0);
    return BlocConsumer<DealOfTheDayCubit, DealOfTheDayState>(
      listener: (context, state) {
        if (state is DealOfTheDayErrorS) {
          showSnackBar(context, state.errorString);
        }
      },
      builder: (context, state) {
        if (state is DealOfTheDaySuccessS) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text('Deal of the day',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(
                              AppRouteConstants.productDetailsScreenRoute.name,
                              extra: {
                                'product': state.product,
                                'deliveryDate': getDeliveryDate(),
                              });
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: state.product.images[state.imageIndex],
                          height: 250,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      state.product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        itemCount: state.product.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<DealOfTheDayCubit>()
                                  .changeDealOfTheDayImage(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  imageUrl: state.product.images[index],
                                  height: 30,
                                  width: 90,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          context.read<DealOfTheDayCubit>().getDealOfTheDay(0);
          return const SizedBox();
        }
      },
    );
  }
}
