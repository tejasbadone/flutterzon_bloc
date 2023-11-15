import 'package:flutter/material.dart';

class AnotherScreen extends StatelessWidget {
  static const String routeName = '/another-screen';
  final String appBarTitle;
  const AnotherScreen({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Text(appBarTitle),
      ),
    );
  }
}
