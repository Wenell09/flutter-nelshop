import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/bottomNavBar/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.orange[300],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          leading: InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              BottomNavBarController.currentPage.value = 2;
              Navigator.of(context).pushReplacementNamed(Routes.BOTTOM_NAV_BAR);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 11),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  FontAwesomeIcons.x,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/nelshop.png",
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login Nelshop",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    controller.login();
                  },
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(8),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: Icon(
                            color: Colors.white,
                            FontAwesomeIcons.google,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Login with Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
