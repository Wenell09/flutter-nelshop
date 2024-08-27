import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/barang_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchBarangController extends GetxController {
  final inputSearch = TextEditingController();
  final barang = <BarangModel>[].obs;
  final isSearch = false.obs;
  final isLoading = true.obs;

  Future<List<BarangModel>> getBarang() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/barang"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        barang.value =
            result.map((json) => BarangModel.fromJson(json)).toList();
        isLoading.value = false;
      } else {
        debugPrint("gagal fetch barang");
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
    return barang;
  }

  Future<List<BarangModel>> searchBarang(String query) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/searchBarang?q=$query"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        barang.value =
            result.map((json) => BarangModel.fromJson(json)).toList();
      } else {
        debugPrint("gagal cari barang");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
    return barang;
  }

  String formatRupiah(double value) {
    final NumberFormat format = NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp",
      decimalDigits: 0,
    );
    return format.format(value);
  }

  void resetInput() {
    searchBarang("");
    inputSearch.clear();
    isSearch.value = false;
  }

  @override
  void onInit() {
    getBarang();
    super.onInit();
  }
}
