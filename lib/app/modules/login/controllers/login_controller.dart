import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/modules/bottomNavBar/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserCredential? userCredential;
  User? userDetail;
  String role = "";

  Future<void> login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await googleSignIn.signOut();
      googleSignInAccount = await googleSignIn.signIn();
      bool isSuccess = await googleSignIn.isSignedIn();
      if (isSuccess) {
        final googleAuth = await googleSignInAccount!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        userCredential = await firebaseAuth.signInWithCredential(credential);
        userDetail = userCredential!.user;
        prefs.setString("userId", userDetail!.uid);
        prefs.setString("homeUserId", userDetail!.uid);
        if (userDetail!.email == "nabilalftrr09@gmail.com") {
          role = "admin";
        } else {
          role = "user";
        }
        final Map<String, dynamic> data = {
          "user_id": userDetail!.uid,
          "role": role,
          "nama": userDetail!.displayName,
          "email": userDetail!.email,
        };
        final response = await http.post(
          Uri.parse("$baseUrl/addAccount"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          debugPrint("result login : $result");
        } else {
          debugPrint("Gagal buat akun/akun sudah terdaftar");
        }
        BottomNavBarController.currentPage.value = 2;
        Get.offNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        debugPrint("Gagal login");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
  }
}
