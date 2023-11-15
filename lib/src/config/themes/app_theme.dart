import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'AmazonEmber',
      scaffoldBackgroundColor: Constants.backgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          modalBackgroundColor: Colors.white),
      colorScheme: const ColorScheme.light(primary: Constants.secondaryColor),
      appBarTheme: const AppBarTheme(
          elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      useMaterial3: true,
    );
  }
}
