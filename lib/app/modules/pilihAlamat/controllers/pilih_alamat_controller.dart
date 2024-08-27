import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:flutter_nelshop/app/modules/pembayaran/controllers/pembayaran_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PilihAlamatController extends GetxController {
  final isSelected = false.obs;
  final alamatId = "".obs;

  void changeSelected(String value) {
    alamatId.value = value;
    isSelected.value = true;
  }

  Future<void> updateAlamatUtama() async {
    Map<String, dynamic> data = {"alamat_utama": true};
    try {
      final response = await http.patch(
          Uri.parse(
              "$baseUrl/updateAlamatUtama/${MyAccountController.userId.value}/${alamatId.value}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        debugPrint("result:${response.body}");
        PembayaranController.getAlamat();
      } else {
        debugPrint("Gagal update alamat utama");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
  }

  Future<void> deleteAlamat(String alamatId) async {
    try {
      final response = await http.delete(Uri.parse(
          "$baseUrl/deleteAlamat/${MyAccountController.userId.value}/$alamatId"));
      if (response.statusCode == 200) {
        debugPrint("results :${response.body}");
        PembayaranController.getAlamat();
      } else {
        debugPrint("Gagal hapus alamat");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
  }
}
