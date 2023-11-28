import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/you_might_also_like_single.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class YouMightAlsoLikeBlock extends StatelessWidget {
  const YouMightAlsoLikeBlock({
    super.key,
    required this.productName,
  });

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customers who viewed $productName... also viewed',
          maxLines: 2,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 250,
          child: BlocBuilder<FetchCategoryProductsBloc,
              FetchCategoryProductsState>(
            builder: (context, state) {
              if (state is FetchCategoryProductsSuccessS) {
                return ListView.builder(
                    itemCount: state.productList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      Product product = state.productList[index];
                      double averageRating = state.averageRatingList[index];
                      return InkWell(
                          onTap: () {
                            context.pushNamed(
                                AppRouteConstants
                                    .productDetailsScreenRoute.name,
                                extra: {
                                  "product": product,
                                  "deliveryDate": getDeliveryDate(),
                                });
                          },
                          child: YouMightAlsoLikeSingle(
                            product: product,
                            averageRating: averageRating,
                          ));
                    }));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }
}
