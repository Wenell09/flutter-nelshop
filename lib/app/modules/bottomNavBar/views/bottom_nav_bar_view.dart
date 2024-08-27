import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/brands/views/brands_view.dart';
import 'package:flutter_nelshop/app/modules/home/views/home_view.dart';
import 'package:flutter_nelshop/app/modules/myAccount/views/my_account_view.dart';

import 'package:get/get.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: BottomNavBarController.currentPage.value,
          children: const [
            HomeView(),
            BrandsView(),
            MyAccountView(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: BottomNavBarController.currentPage.value,
            onTap: (value) => controller.changePage(value),
            selectedIconTheme: const IconThemeData(color: Colors.orange),
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.window_rounded),
                label: "Brands",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Account saya",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
