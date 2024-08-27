import 'package:flutter_nelshop/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<MyAccountController>(
      () => MyAccountController(),
    );
  }
}
