import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:polaris/constant/app_text.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.homePageHeading),
      ),
      body: const Center(
        child: Text(AppText.homeContentText),
      ),
    );
  }
}
