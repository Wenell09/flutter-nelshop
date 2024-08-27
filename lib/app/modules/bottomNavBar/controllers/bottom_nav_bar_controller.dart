import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  static final currentPage = 0.obs;
  void changePage(int value) {
    currentPage.value = value;
  }
}
