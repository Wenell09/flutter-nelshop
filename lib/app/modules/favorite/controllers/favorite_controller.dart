import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FavoriteController extends GetxController {
  String formatRupiah(double value) {
    final NumberFormat format = NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp",
      decimalDigits: 0,
    );
    return format.format(value);
  }
}
