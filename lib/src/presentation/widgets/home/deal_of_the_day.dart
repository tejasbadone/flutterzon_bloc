import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  // final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    // fetchDealOfTheDay();
  }

  // void fetchDealOfTheDay() async {
  //   product = await homeServices.fetchDealOfTheDay(context: context);
  //   if (context.mounted) {
  //     setState(() {});
  //   }
  // }

  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const SizedBox()
        : product!.name.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Deal of the day',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
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
                              // navigateToProductDetails(
                              //     context: context,
                              //     product: product!,
                              //     deliveryDate: getDeliveryDate());
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: product!.images[imageIndex],
                              height: 250,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          product!.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemCount: product!.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.contain,
                                      imageUrl: product!.images[index],
                                      height: 70,
                                      width: 90,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
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
  }
}
