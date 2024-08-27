import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/user_model.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static final userId = "".obs;
  final user = <UserModel>[].obs;
  final isLoading = true.obs;

  void cekUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final getId = prefs.getString("userId") ?? "";
    userId.value = getId;
    if (userId.value.isEmpty) {
      debugPrint("id kosong");
    } else {
      getDataUser();
    }
  }

  Future<List<UserModel>> getDataUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response =
          await http.get(Uri.parse("$baseUrl/account/${userId.value}"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        user.value = result.map((json) => UserModel.fromJson(json)).toList();
        isLoading.value = false;
        prefs.setString("userId", userId.value);
      } else {
        debugPrint("Gagal mendapatkan data akun");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    user.clear();
    userId.value = "";
    HomeController.homeUserId.value = "";
    HomeController.keranjangUser.clear();
    HomeController.favoriteUser.clear();
    prefs.setString("userId", userId.value);
    prefs.setString("homeUserId", HomeController.homeUserId.value);
  }

  @override
  void onInit() {
    cekUserId();
    super.onInit();
  }
}
