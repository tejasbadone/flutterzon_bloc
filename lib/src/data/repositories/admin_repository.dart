import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/admin_api.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/four_images_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/sales.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AdminRepository {
  final AdminApi adminApi = AdminApi();

  Future<List<String>> uploadImages({
    String? name,
    String? title,
    required String category,
    required List<File> images,
    bool isOffer = false,
  }) async {
    try {
      List<String> imageUrls = [];
      String folder;
      final String cloudinaryCloudName = dotenv.env['CLOUDINARY_CLOUDNAME']!;
      final String cloudinaryUploadPreset =
          dotenv.env['CLOUDINARY_UPLOADPRESET']!;

      final cloudinary = CloudinaryPublic(
          cloudinaryCloudName, cloudinaryUploadPreset,
          cache: false);

      if (isOffer) {
        String folderName = formatFolderName(title!);
        folder = 'Offers/Four Images Offers/$category/$folderName';
      } else {
        String folderName = formatFolderName(name!);

        folder = 'products/$category/$folderName';
      }

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path,
                resourceType: CloudinaryResourceType.Image, folder: folder));

        imageUrls.add(res.secureUrl);
      }

      return imageUrls;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> adminAddProduct({
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      List<String> imageUrls;

      imageUrls =
          await uploadImages(name: name, category: category, images: images);

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await adminApi.adminAddProduct(product: product);

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> adminAddFourImagesOffer({
    required String title,
    required List<File> images,
    required List<String> labels,
    required String category,
  }) async {
    try {
      List<String> imageUrls;

      imageUrls = await uploadImages(
          title: title, category: category, images: images, isOffer: true);

      FourImagesOffer fourImagesOffer = FourImagesOffer(
          title: title, images: imageUrls, labels: labels, category: category);

      http.Response res =
          await adminApi.addFourImagesOffer(fourImagesOffer: fourImagesOffer);

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<FourImagesOffer>> adminGetFourImagesOffer() async {
    try {
      List<FourImagesOffer> fourImagesOfferList = [];
      http.Response res = await adminApi.adminGetFourImagesOffer();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          fourImagesOfferList.add(
            FourImagesOffer.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return fourImagesOfferList;
      } else {
        throw Exception(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<FourImagesOffer>> adminDeleteFourImagesOffer(
      {required String offerId}) async {
    try {
      List<FourImagesOffer> fourImagesOfferList = [];
      http.Response res =
          await adminApi.adminDeleteFourImagesOffer(offerId: offerId);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          fourImagesOfferList.add(
            FourImagesOffer.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return fourImagesOfferList;
      } else {
        throw Exception(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> adminGetCategoryProducts(
      {required String category}) async {
    try {
      List<Product> categoryProducts = [];

      http.Response res =
          await adminApi.adminGetCategoryProducts(category: category);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          categoryProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return categoryProducts;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> adminDeleteProduct({required Product product}) async {
    try {
      http.Response res = await adminApi.adminDeleteProduct(product: product);

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Order>> adminGetOrders() async {
    try {
      List<Order> ordersList = [];
      http.Response res = await adminApi.adminGetOrders();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          ordersList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return ordersList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> adminChangeOrderStatus(
      {required String orderId, required int status}) async {
    try {
      int resStatus;
      http.Response res = await adminApi.adminChangeOrderStatus(
          status: status, orderId: orderId);

      if (res.statusCode == 200) {
        resStatus = jsonDecode(res.body);
        return resStatus;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> adminGetAnalytics() async {
    try {
      List<Sales> sales;
      int totalEarnings;

      http.Response res = await adminApi.adminGetAnalytics();

      if (res.statusCode == 200) {
        var resDecoded = jsonDecode(res.body);

        totalEarnings = resDecoded['totalEarnings'];

        sales = [
          Sales('Mobiles', resDecoded['mobileEarnings'] ?? 0),
          Sales('Fashion', resDecoded['fashionEarnings'] ?? 0),
          Sales('Electronics', resDecoded['electronicsEarnings'] ?? 0),
          Sales('Home', resDecoded['homeEarnings'] ?? 0),
          Sales('Beauty', resDecoded['beautyEarnings'] ?? 0),
          Sales('Appliances', resDecoded['appliancesEarnings'] ?? 0),
          Sales('Grocery', resDecoded['groceryEarnings'] ?? 0),
          Sales('Books', resDecoded['booksEarnings'] ?? 0),
          Sales('Essentials', resDecoded['essentialsEarnings'] ?? 0),
        ];

        return {
          'sales': sales,
          'totalEarnings': totalEarnings,
        };
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
