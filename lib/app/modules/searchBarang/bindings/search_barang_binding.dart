import 'package:get/get.dart';

import '../controllers/search_barang_controller.dart';

class SearchBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchBarangController>(
      () => SearchBarangController(),
    );
  }
}
