import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KeranjangController extends GetxController {
  Future<void> kurangQuantity(
    int index,
    int quantity,
    String keranjangId,
    int harga,
  ) async {
    if (quantity == 1) {
      quantity = 1;
    } else {
      quantity -= index;
      final totalHargaUpdate = harga * quantity;
      Map<String, dynamic> data = {
        "quantity": quantity,
        "total_harga": totalHargaUpdate,
      };
      final response = await http.patch(
        Uri.parse(
            "$baseUrl/updateShoppingCart/${MyAccountController.userId.value}/$keranjangId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint("result : ${response.body}");
        HomeController.getShoppingCartUser();
      } else {
        debugPrint("Gagal update data keranjang");
      }
    }
  }

  Future<void> tambahQuantity(
    int index,
    int quantity,
    String keranjangId,
    int harga,
  ) async {
    if (quantity == 100) {
      quantity = 100;
    } else {
      quantity += index;
      final totalHargaUpdate = harga * quantity;
      Map<String, dynamic> data = {
        "quantity": quantity,
        "total_harga": totalHargaUpdate,
      };
      final response = await http.patch(
        Uri.parse(
            "$baseUrl/updateShoppingCart/${MyAccountController.userId.value}/$keranjangId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint("result : ${response.body}");
        HomeController.getShoppingCartUser();
      } else {
        debugPrint("Gagal update data keranjang");
      }
    }
  }

  Future<void> deleteShoppingCartUser(String keranjangId) async {
    try {
      String urikeranjangId = "";
      if (keranjangId.isNotEmpty) {
        urikeranjangId = "/$keranjangId";
      }
      final response = await http.delete(Uri.parse(
          "$baseUrl/deleteShoppingCart/${MyAccountController.userId.value}$urikeranjangId"));
      if (response.statusCode == 200) {
        debugPrint("result : ${response.body}");
        HomeController.getShoppingCartUser();
      } else {
        debugPrint("gagal hapus data keranjang user");
      }
    } catch (e) {
      debugPrint("error : $e");
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
}
