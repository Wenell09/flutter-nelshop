import 'package:get/get.dart';

import '../controllers/pilih_alamat_controller.dart';

class PilihAlamatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihAlamatController>(
      () => PilihAlamatController(),
    );
  }
}
