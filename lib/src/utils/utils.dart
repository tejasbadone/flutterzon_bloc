import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void precatchedImage(List<String> images, BuildContext context) {
  for (String image in images) {
    precacheImage(NetworkImage(image), context);
  }
}

void precatchedImageMap(
    List<Map<String, String>> images, BuildContext context) {
  for (Map<String, String> image in images) {
    precacheImage(NetworkImage(image['image']!), context);
  }
}

// void precacheAllImage(context) {
//   precatchedImageMap(GlobalVariables.carouselImages, context);
//   precatchedImageMap(GlobalVariables.bottomOfferImages, context);
//   precatchedImageMap(GlobalVariables.multiImageOffer1, context);
//   precatchedImageMap(GlobalVariables.multiImageOffer2, context);
//   precatchedImageMap(GlobalVariables.multiImageOffer3, context);
//   precatchedImageMap(GlobalVariables.multiImageOffer4, context);
//   precatchedImageMap(GlobalVariables.multiImageOffer5, context);
// }

String formatFolderName(String productName) {
  var formattedName = productName.replaceAll(' ', '-');

  if (formattedName.length > 255) {
    formattedName = formattedName.substring(0, 255);
  }
  formattedName = formattedName.replaceAll(RegExp(r'[^\w\-_]'), '');

  return formattedName;
}

String getDeliveryDate() {
  final DateTime currentDate = DateTime.now();
  final int randomDay = Random().nextInt(15) + 1;
  final DateTime deliveryDate = currentDate.add(Duration(days: randomDay));
  String formattedDeliveryDate =
      DateFormat('EEEE, dd MMMM').format(deliveryDate);
  return formattedDeliveryDate;
}

formatDate(int date) {
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');
  final String formattedOrderDate =
      formatter.format(DateTime.fromMillisecondsSinceEpoch(date));
  return formattedOrderDate;
}

String formatPrice(num price) {
  final NumberFormat numberFormatter = NumberFormat.decimalPattern('en_US');
  numberFormatter.minimumFractionDigits = 0;
  numberFormatter.maximumFractionDigits = 0;

  final String formattedPrice = numberFormatter.format(price);
  return formattedPrice;
}

String formatPriceWithDecimal(num price) {
  final NumberFormat numberFormatter = NumberFormat.decimalPattern('en_US');
  numberFormatter.minimumFractionDigits = 2;
  numberFormatter.maximumFractionDigits = 2;

  final String formattedPrice = numberFormatter.format(price);
  return formattedPrice;
}

String formatLakhs(int lakhs) {
  final formatter = NumberFormat.compact(locale: 'en_IN');
  final String formattedAmount = formatter.format(lakhs);
  return formattedAmount;
}

String getEmi(Product product) {
  final double emi = (product.price) / 21;
  final String formattedEmi = formatPrice(emi);
  return formattedEmi;
}

String getStatus(int status) {
  if (status == 0 || status == 1) {
    return 'Received';
  } else if (status == 2) {
    return 'Dispatched';
  } else if (status == 3) {
    return 'In Transit';
  } else if (status == 4) {
    return 'Delivered';
  }
  return '';
}

String getSubStatus(int status) {
  if (status == 0 || status == 1) {
    return 'Your order has been received and is currently being processed by the seller.';
  } else if (status == 2) {
    return 'Your order has been shipped and dispatched.';
  } else if (status == 3) {
    return 'Your order is currently in transit.';
  } else if (status == 4) {
    return 'Your order has been delivered.';
  }
  return '';
}

String capitalizeFirstLetter({required String string}) {
  String firstLetter = string[0].toUpperCase();
  String remainingString = string.substring(1, string.length);

  return firstLetter + remainingString;
}

Random random = Random();

String getRandomFromMap(List<Map<String, String>> map) {
  int randomIndex = random.nextInt(map.length);

  Map<String, String> randomMap = map[randomIndex];

  String randomTitle = randomMap['title']!;

  return randomTitle;
}

int getUniqueRandomInt({required max}) {
  Set<int> randomIntSet = <int>{};

  int randomInt;

  while (true) {
    randomInt = random.nextInt(max);
    if (!randomIntSet.contains(randomInt)) {
      break;
    }
  }

  return randomInt;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  String token = pref.getString('x-auth-token')!;

  return token;
}
