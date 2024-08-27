import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed(Routes.BOTTOM_NAV_BAR),
    );
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/nelshop.png",
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Welcome To Nelshop",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
