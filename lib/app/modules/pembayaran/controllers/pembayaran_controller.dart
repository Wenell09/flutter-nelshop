import 'dart:convert';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/alamat_model.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PembayaranController extends GetxController {
  static final alamat = <AlamatModel>[].obs;
  static final alamatUtama = <AlamatModel>[].obs;
  final kurirCode = "".obs;
  final ongkir = 0.obs;
  final totalKeseluruhan = 0.obs;

  static Future<List<AlamatModel>> getAlamat() async {
    try {
      final response = await http.get(
          Uri.parse("$baseUrl/alamat/${MyAccountController.userId.value}"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        alamat.value =
            result.map((json) => AlamatModel.fromJson(json)).toList();
        alamatUtama.value =
            alamat.where((data) => data.alamatUtama == 1).toList();
      } else {
        alamat.clear();
        debugPrint("gagal get alamat");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
    return alamat;
  }

  Future<void> getBiayaOngkir(String destination, String weight) async {
    try {
      final response = await http.post(
        Uri.parse("$rajaApiUrl/cost"),
        headers: {
          "key": apiKey,
          "content-type": "application/x-www-form-urlencoded",
        },
        body: {
          "origin": "153",
          "destination": destination,
          "weight": weight,
          "courier": kurirCode.value,
        },
      );
      if (response.statusCode == 200) {
        final int resultOngkir = jsonDecode(response.body)["rajaongkir"]
            ["results"][0]["costs"][0]["cost"][0]["value"];
        ongkir.value = resultOngkir;
        totalKeseluruhan.value = HomeController.totalBayar.value + ongkir.value;
        debugPrint("ongkir : ${ongkir.value}");
        debugPrint("hasil: ${totalKeseluruhan.value}");
      } else {
        debugPrint("gagal mendapatkan biaya ongkir");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
  }

  String formatRupiah(double value) {
    final NumberFormat format = NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp",
      decimalDigits: 0,
    );
    return format.format(value);
  }

  @override
  void onInit() {
    getAlamat();
    super.onInit();
  }
}
