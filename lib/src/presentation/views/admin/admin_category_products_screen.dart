import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_fetch_category_products/admin_fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/admin/admin_home_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/account/single_product.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminCategoryProductsScreen extends StatelessWidget {
  const AdminCategoryProductsScreen({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    context
        .read<AdminFetchCategoryProductsBloc>()
        .add(AdminFetchCategoryProductsPressedE(category: category));

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () =>
            context.pushNamed(AppRouteConstants.adminAddProductsScreen.name),
        toolTip: 'Add a product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<AdminFetchCategoryProductsBloc,
                AdminFetchCategoryProductsState>(
              listener: (context, state) {
                if (state is AdminFetchCategoryProductsErrorS) {
                  showSnackBar(context, state.errorString);
                }
              },
              builder: (context, state) {
                if (state is AdminFetchCategoryProductsLoadingS) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is AdminFetchCategoryProductsSuccessS) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          '${state.categoryProducts.length} Results in $category',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.categoryProducts.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          final product = state.categoryProducts[index];
                          return InkWell(
                            onTap: () => context.pushNamed(
                                AppRouteConstants
                                    .productDetailsScreenRoute.name,
                                extra: {
                                  'product': product,
                                  'deliveryDate': getDeliveryDate()
                                }),
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child:
                                        SingleProduct(image: product.images[0]),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Text(
                                            product.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: IconButton(
                                            onPressed: () async {
                                              context
                                                  .read<
                                                      AdminFetchCategoryProductsBloc>()
                                                  .add(
                                                      AdminDeleteProductPressedE(
                                                          product: product,
                                                          category: category));
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
