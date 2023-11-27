import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_text_button.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/menu/container_clipper.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = '/menu-screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      bottomSheet: BottomSheet(
          onClosing: () {},
          constraints: const BoxConstraints(maxHeight: 80, minHeight: 80),
          builder: ((context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextButton(
                    buttonText: 'Orders',
                    onPressed: () => context.pushNamed(
                        AppRouteConstants.yourOrdersScreenRoute.name),
                    isMenuScreenButton: true),
                CustomTextButton(
                    buttonText: 'History',
                    onPressed: () => context.pushNamed(
                        AppRouteConstants.browsingHistoryScreenRoute.name),
                    isMenuScreenButton: true),
                CustomTextButton(
                    buttonText: 'Account',
                    onPressed: () {},
                    isMenuScreenButton: true),
                CustomTextButton(
                    buttonText: 'Wish List',
                    onPressed: () => context.pushNamed(
                        AppRouteConstants.yourWishListScreenRoute.name),
                    isMenuScreenButton: true),
              ],
            );
          })),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff84D8E3),
            Color(0xffA6E6CE),
            Color.fromARGB(255, 241, 249, 252),
          ], stops: [
            0,
            0.3,
            0.7
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),
        child: GridView.builder(
            itemCount: Constants.menuScreenImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
                crossAxisCount: 3),
            itemBuilder: ((context, index) {
              Map<String, String> category = Constants.menuScreenImages[index];

              return MenuCategoryContainer(
                title: category['title']!,
                category: category['category']!,
                imageLink: category['image']!,
              );
              // );
            })),
      ),
    );
  }
}

class MenuCategoryContainer extends StatelessWidget {
  const MenuCategoryContainer({
    super.key,
    required this.title,
    required this.imageLink,
    required this.category,
  });

  final String title;
  final String imageLink;
  final String category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
          AppRouteConstants.categoryproductsScreenRoute.name,
          pathParameters: {'category': category}),
      child: Container(
        height: 170,
        width: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500.withOpacity(0.35),
                blurRadius: 3,
                offset: const Offset(0, 0),
                spreadRadius: 3)
          ],
          border: Border.all(color: Colors.grey.shade500, width: 1),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: ContainerClipper(),
                child: Container(
                  height: 170,
                  width: 125,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 249, 254),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: CachedNetworkImage(
                imageUrl: imageLink,
                width: 120,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
                left: 12,
                top: 10,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
