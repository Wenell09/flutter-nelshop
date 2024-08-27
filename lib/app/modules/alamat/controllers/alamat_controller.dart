import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:flutter_nelshop/app/modules/pembayaran/controllers/pembayaran_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/city_model.dart';
import 'package:flutter_nelshop/app/data/models/province_model.dart';

class AlamatController extends GetxController {
  final province = <ProvinceModel>[].obs;
  final city = <CityModel>[].obs;
  final provinceId = "".obs;
  final provinceName = "".obs;
  final cityName = "".obs;
  final cityId = "".obs;
  final hiddenCity = false.obs;
  final hiddenSave = true.obs;
  final inputNama = TextEditingController();
  final inputNomorHp = TextEditingController();
  final inputAlamat = TextEditingController();
  final inputKodePos = TextEditingController();

  Future<void> tambahAlamat() async {
    try {
      Map<String, dynamic> data = {
        "user_id": MyAccountController.userId.value,
        "nama_penerima": inputNama.text,
        "no_handphone": inputNomorHp.text,
        "alamat_rumah": inputAlamat.text,
        "provinsi_id": provinceId.value,
        "provinsi": provinceName.value,
        "kota_kabupaten_id": cityId.value,
        "kota_kabupaten": cityName.value,
        "kode_pos": int.parse(inputKodePos.text),
        "alamat_utama": false,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addAlamat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          dismissDirection: DismissDirection.horizontal,
          "Berhasil",
          "berhasil menambahkan alamat!",
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        PembayaranController.getAlamat();
        debugPrint("result :${response.body}");
      } else {
        Get.snackbar(
          dismissDirection: DismissDirection.horizontal,
          "Gagal",
          "gagal menambahkan alamat!",
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        debugPrint("result :${response.body}");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
  }

  Future<List<ProvinceModel>> getProvince() async {
    try {
      final response = await http
          .get(Uri.parse("$rajaApiUrl/province"), headers: {"key": apiKey});
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["rajaongkir"]["results"];
        province.value =
            result.map((json) => ProvinceModel.fromJson(json)).toList();
      } else {
        debugPrint("gagal fetch province");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
    return province;
  }

  Future<List<CityModel>> getCity(String provinceId) async {
    try {
      final response = await http.get(
          Uri.parse("$rajaApiUrl/city?province=$provinceId"),
          headers: {"key": apiKey});
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["rajaongkir"]["results"];
        city.value = result.map((json) => CityModel.fromJson(json)).toList();
      } else {
        debugPrint("gagal fetch city");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
    return city;
  }

  void validasi() {
    if (inputNama.text.isEmpty ||
        inputAlamat.text.isEmpty ||
        inputNomorHp.text.isEmpty ||
        inputKodePos.text.isEmpty ||
        provinceId.value.isEmpty ||
        cityId.value.isEmpty) {
      hiddenSave.value = true;
    } else {
      hiddenSave.value = false;
    }
  }
}
