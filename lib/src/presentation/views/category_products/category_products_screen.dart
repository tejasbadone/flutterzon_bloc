import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/single_listing_product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;
  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: BlocConsumer<FetchCategoryProductsBloc, FetchCategoryProductsState>(
        listener: ((context, state) {
          if (state is FetchCategoryProductsErrorS) {
            showSnackBar(context, state.errorString);
          }
        }),
        builder: (context, state) {
          if (state is FetchCategoryProductsLoadingS) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchCategoryProductsSuccessS) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 0.4)),
                  child: Text(
                    'Over ${state.productList.length} Results in $category',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.productList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final product = state.productList[index];
                        final averageRating = state.averageRatingList[index];

                        return SingleListingProduct(
                          product: product,
                          averageRating: averageRating,
                          deliveryDate: getDeliveryDate(),
                        );
                      }),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
