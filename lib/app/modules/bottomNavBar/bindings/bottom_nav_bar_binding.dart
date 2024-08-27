import 'package:flutter_nelshop/app/modules/brands/controllers/brands_controller.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(
      () => BottomNavBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BrandsController>(
      () => BrandsController(),
    );
    Get.lazyPut<MyAccountController>(
      () => MyAccountController(),
    );
  }
}
