import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/stars.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddToCartOffer extends StatelessWidget {
  const AddToCartOffer({
    super.key,
    required this.product,
    required this.averageRating,
  });

  final Product product;
  final double averageRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.pushNamed(
                    AppRouteConstants.productDetailsScreenRoute.name,
                    extra: {
                      "product": product,
                      "deliveryDate": getDeliveryDate(),
                    });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      product.images[0],
                      height: 130,
                      width: 130,
                    ),
                  ),
                  Text(
                    product.name,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Constants.selectedNavBarColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Row(
                    children: [
                      Stars(
                        rating: averageRating,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        product.rating!.length.toString(),
                        style: TextStyle(
                          color: Constants.selectedNavBarColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹ ${formatPriceWithDecimal(product.price)}',
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffB12704),
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showSnackBar(context, 'Added to Cart!');
                context
                    .read<CartBloc>()
                    .add(AddToCartFromBottomSheet(product: product));
              },
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  minimumSize: WidgetStatePropertyAll(Size(100, 35)),
                  maximumSize: WidgetStatePropertyAll(Size(100, 35)),
                  fixedSize: WidgetStatePropertyAll(Size(100, 35)),
                  backgroundColor:
                      WidgetStatePropertyAll(Constants.yellowColor)),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
