import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/menu/container_clipper.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:go_router/go_router.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                childAspectRatio: 1.1,
                crossAxisCount: 2),
            itemBuilder: ((context, index) {
              Map<String, String> category = Constants.menuScreenImages[index];

              return MenuCategoryContainerAdmin(
                title: category['category']!,
                category: category['category']!,
                imageLink: category['image']!,
              );
              // );
            })),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () =>
            context.pushNamed(AppRouteConstants.adminAddProductsScreen.name),
        toolTip: 'Add a product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.toolTip,
  });

  final void Function()? onPressed;
  final String toolTip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: Constants.selectedNavBarColor,
      tooltip: toolTip,
      child: const Icon(Icons.add),
    );
  }
}

class MenuCategoryContainerAdmin extends StatelessWidget {
  const MenuCategoryContainerAdmin({
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
      onTap: () {
        context.pushNamed(AppRouteConstants.adminCategoryProductsScreen.name,
            extra: category);
      },
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
                  width: 200,
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
                height: 110,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
                left: 16,
                top: 10,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
