import 'package:get/get.dart';

import '../controllers/detail_brands_controller.dart';

class DetailBrandsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBrandsController>(
      () => DetailBrandsController(),
    );
  }
}
