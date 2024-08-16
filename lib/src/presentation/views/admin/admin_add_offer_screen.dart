import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/four-images-offer/admin_four_image_offer_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/add_product_images/admin_add_products_images_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/select_category_cubit/admin_add_select_category_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/admin/admin_add_product_screen.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddOfferScreen extends StatelessWidget {
  const AdminAddOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminAddProductsImagesBloc>().add(ClearImagesPressedE());
    context.read<AdminAddSelectCategoryCubit>().resetCategory();
    final multiImageFormKey = GlobalKey<FormState>();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController label1Controller = TextEditingController();
    final TextEditingController label2Controller = TextEditingController();
    final TextEditingController label3Controller = TextEditingController();
    final TextEditingController label4Controller = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Constants.appBarGradient),
          ),
          title: const Text('Add Offer'),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AdminFourImageOfferCubit, AdminFourImageOfferState>(
          listener: (context, state) {
            if (state is AdminFourImageOfferErrorS) {
              showSnackBar(context, state.errorString);
            }

            if (state is AdminAddFourImageOfferSuccessS) {
              Navigator.pop(context);
              showSnackBar(context, 'Offer added successfully!');
            }
          },
          builder: (context, state) {
            if (state is AdminFourImageOfferLoadingS) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.2,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Adding offer...')
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfield(
                        controller: titleController,
                        hintText: 'Title',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      BlocConsumer<AdminAddProductsImagesBloc,
                          AdminAddProductsImagesState>(
                        listener: (context, state) {
                          if (state is AdminAddProductsErrorS) {
                            showSnackBar(context, 'Please add offer images');
                          }
                        },
                        builder: (context, state) {
                          if (state is AdminAddProductsImagesSelectedS) {
                            return Form(
                              key: multiImageFormKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      state.imagesList.length > 1
                                          ? const Icon(
                                              Icons.chevron_left_rounded,
                                              color: Constants.secondaryColor,
                                            )
                                          : const SizedBox(),
                                      Expanded(
                                        child: CarouselSlider(
                                          items: state.imagesList.map((i) {
                                            return Builder(
                                                builder: (context) =>
                                                    Image.file(
                                                      i,
                                                      fit: BoxFit.cover,
                                                    ));
                                          }).toList(),
                                          options: CarouselOptions(
                                              height: 230,
                                              viewportFraction: 1,
                                              initialPage: 0),
                                        ),
                                      ),
                                      state.imagesList.length > 1
                                          ? const Icon(
                                              Icons.chevron_right_rounded,
                                              color: Constants.secondaryColor,
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  TextButton.icon(
                                      onPressed: () => context
                                          .read<AdminAddProductsImagesBloc>()
                                          .add(SelectImagesPressedE()),
                                      style: const ButtonStyle(
                                          side: WidgetStatePropertyAll(
                                              BorderSide(
                                                  width: 1,
                                                  color: Constants
                                                      .secondaryColor))),
                                      icon: const Icon(Icons.add),
                                      label: const Text('Select images'))
                                ],
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () => context
                                  .read<AdminAddProductsImagesBloc>()
                                  .add(SelectImagesPressedE()),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: Colors.black54,
                                borderPadding:
                                    const EdgeInsets.symmetric(horizontal: 5)
                                        .copyWith(top: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                        color: Colors.black54,
                                      ),
                                      Text('Select offer images',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade400))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: label1Controller,
                        hintText: 'Label 1',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomTextfield(
                        controller: label2Controller,
                        hintText: 'Label 2',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomTextfield(
                        controller: label3Controller,
                        hintText: 'Label 3',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomTextfield(
                        controller: label4Controller,
                        hintText: 'Label 4',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: BlocBuilder<AdminAddSelectCategoryCubit,
                            AdminAddSelectCategoryState>(
                          builder: (context, state) {
                            if (state is AdminAddProductsSelectCategory) {
                              return CustomDropDown(
                                inputBorderStyle: Constants.inputBorderStyle,
                                productCategories: Constants.productCategories,
                                currentCategory: state.category,
                                valueStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              );
                            } else {
                              return CustomDropDown(
                                inputBorderStyle: Constants.inputBorderStyle,
                                productCategories: Constants.productCategories,
                                currentCategory: Constants.productCategories[0],
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButton(
                        buttonText: 'Add Offer',
                        onPressed: () async {
                          try {
                            List<File> imagesList = context
                                .read<AdminAddProductsImagesBloc>()
                                .imagesList!;
                            String category = context
                                .read<AdminAddSelectCategoryCubit>()
                                .category!;

                            if (multiImageFormKey.currentState!.validate() &&
                                imagesList.isNotEmpty &&
                                category != 'Category' &&
                                titleController.text.isNotEmpty &&
                                label1Controller.text.isNotEmpty &&
                                label2Controller.text.isNotEmpty &&
                                label3Controller.text.isNotEmpty &&
                                label4Controller.text.isNotEmpty) {
                              await context
                                  .read<AdminFourImageOfferCubit>()
                                  .addFourImagesOffer(
                                      title: titleController.text,
                                      images: imagesList,
                                      label1: label1Controller.text,
                                      label2: label2Controller.text,
                                      label3: label3Controller.text,
                                      label4: label4Controller.text,
                                      category: category);
                            } else {
                              showSnackBar(context,
                                  'Error! please make sure you have filled form correctly!');
                            }
                          } catch (e) {
                            if (context.mounted) {
                              showSnackBar(
                                  context, 'Please fill the form correctly!');
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// not added in the app, as there are not much single image offers in the current version of app
// class SingleImageOfferWidget extends StatelessWidget {
//   const SingleImageOfferWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final singleImageFormKey = GlobalKey<FormState>();

//     final TextEditingController titleController = TextEditingController();
//     final TextEditingController subTitleController = TextEditingController();

//     return Padding(
//       padding: const EdgeInsets.all(8.0).copyWith(top: 14),
//       child: Form(
//         key: singleImageFormKey,
//         child: Column(
//           children: [
//             BlocConsumer<SingleImageCubit, SingleImageState>(
//               listener: (context, state) {
//                 if (state is SingleImageError) {
//                   showSnackBar(context, state.errorString);
//                 }
//               },
//               builder: (context, state) {
//                 if (state is SingleImageSelected) {
//                   return Column(
//                     children: [
//                       const SizedBox(height: 8),
//                       Image.file(
//                         state.image,
//                         height: 300,
//                       ),
//                       const SizedBox(
//                         height: 14,
//                       ),
//                       TextButton.icon(
//                           onPressed: () =>
//                               context.read<SingleImageCubit>().singleImage(),
//                           style: const ButtonStyle(
//                               side: MaterialStatePropertyAll(BorderSide(
//                                   width: 1, color: Constants.secondaryColor))),
//                           icon: const Icon(Icons.edit, size: 20),
//                           label: const Text('Edit image'))
//                     ],
//                   );
//                 }

//                 return GestureDetector(
//                   onTap: () => context.read<SingleImageCubit>().singleImage(),
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: const Radius.circular(10),
//                     dashPattern: const [10, 4],
//                     strokeCap: StrokeCap.round,
//                     color: Colors.black54,
//                     borderPadding: const EdgeInsets.symmetric(horizontal: 5)
//                         .copyWith(top: 5),
//                     child: Container(
//                       width: double.infinity,
//                       height: 150,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.folder_open,
//                             size: 40,
//                             color: Colors.black54,
//                           ),
//                           Text('Select offer image',
//                               style: TextStyle(
//                                   fontSize: 15, color: Colors.grey.shade400))
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             CustomTextfield(
//               controller: titleController,
//               hintText: 'Title',
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             CustomTextfield(
//               controller: subTitleController,
//               hintText: 'Subtitle',
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             CustomElevatedButton(
//               buttonText: 'Add Offer',
//               onPressed: () {},
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
