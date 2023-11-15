import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/search/bloc/search_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/single_listing_product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/address_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchErrorS) {
            showSnackBar(context, state.errorString);
          }
        },
        builder: (context, state) {
          if (state is SearchLoadingS) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchSuccessS) {
            return Column(
              children: [
                const AddressBar(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.searchProducts.length,
                    itemBuilder: ((context, index) {
                      final product = state.searchProducts[index];

                      return GestureDetector(
                        onTap: () {
                          //TODO products deatils screen
                          // Navigator.pushNamed(
                          //     context, ProductDetailsScreen.routeName,
                          //     arguments: product);
                        },
                        child: SingleListingProduct(
                          product: product,
                          deliveryDate: getDeliveryDate(),
                        ),
                      );
                    }),
                  ),
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
