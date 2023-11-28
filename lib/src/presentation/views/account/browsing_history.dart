import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/keep_shopping_for/cubit/keep_shopping_for_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/single_listing_product.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowsingHistory extends StatelessWidget {
  const BrowsingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Browsing History',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              Column(
                children: [
                  const Text(
                    'These items were viewed recently, We use them to personalise recommendations.',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<KeepShoppingForCubit, KeepShoppingForState>(
                    listener: (context, state) {
                      if (state is KeepShoppingForErrorS) {
                        showSnackBar(context, state.errorString);
                      }
                    },
                    builder: (context, state) {
                      if (state is KeepShoppingForLoadingS) {
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height / 1.4,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is KeepShoppingForSuccessS) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.productList.length,
                          itemBuilder: ((context, index) {
                            return SingleListingProduct(
                                product: state.productList[index],
                                averageRating: state.averageRatingList[index],
                                deliveryDate: getDeliveryDate());
                          }),
                        );
                      }

                      return const Center(
                        child: Text('No products in browsing history'),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
