import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyAccountView extends GetView<MyAccountController> {
  const MyAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Obx(
            () => (MyAccountController.userId.value.isEmpty)
                ? ProfileView(
                    controller: controller,
                    login: "Login",
                    username: "***********",
                    email: "***********",
                  )
                : (controller.isLoading.value)
                    ? const ShimmerLoading()
                    : ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final user = controller.user[index];
                          return ProfileView(
                            controller: controller,
                            login: user.nama,
                            username: user.nama,
                            email: user.email,
                          );
                        },
                        itemCount: controller.user.length,
                      ),
          ),
        ],
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 150,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 100,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 100,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 100,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 100,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Colors.orange[800],
                  size: 30,
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListTile(
                leading: const Icon(
                  Icons.dark_mode,
                  size: 30,
                ),
                title: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Colors.orange[800],
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 100,
                  height: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.28 - 65,
          left: MediaQuery.of(context).size.width / 2 - 62.5,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 125,
              height: 125,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileView extends StatelessWidget {
  final MyAccountController controller;
  final String login, username, email;
  const ProfileView({
    super.key,
    required this.controller,
    required this.login,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: InkWell(
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: const Color.fromRGBO(0, 0, 0, 0),
                onTap: () => (MyAccountController.userId.value.isEmpty)
                    ? Navigator.of(context).pushReplacementNamed(Routes.LOGIN)
                    : null,
                child: Text(
                  login,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Username",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Email",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Text(
                email,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(),
            (MyAccountController.userId.value.isNotEmpty)
                ? Column(
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                ),
                                actionsAlignment: MainAxisAlignment.spaceAround,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: const Text(
                                  textAlign: TextAlign.center,
                                  "Apakah Anda yakin untuk keluar?",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      "Batal",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.logout();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.orange[800],
                            size: 30,
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.orange[800],
                            size: 30,
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  )
                : Container(),
            ListTile(
              leading: Icon(
                Icons.dark_mode,
                color: Colors.orange[800],
                size: 30,
              ),
              title: const Text(
                "dark Mode",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              textAlign: TextAlign.center,
              "Versi Aplikasi\n1.0.0",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.28 - 65,
          left: MediaQuery.of(context).size.width / 2 - 62.5,
          child: Container(
            width: 125,
            height: 125,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
