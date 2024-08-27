import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: const Text(
          "Favorite",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(() => ListView(
            children: [
              (HomeController.homeUserId.value.isEmpty)
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          "Belum ada daftar favorite",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  : (HomeController.favoriteUser.isEmpty)
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              "Belum ada daftar favorite",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceAround,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: const Text(
                                        textAlign: TextAlign.center,
                                        "Hapus semua dari favorite?",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text(
                                            "Tidak",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            HomeController.deleteFavoriteUser(
                                                "");
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Ya",
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
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  margin: const EdgeInsets.only(left: 25),
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height: MediaQuery.of(context).size.height *
                                      0.0375,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white,
                                      ),
                                      Flexible(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Hapus semua",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final favoriteUser =
                                    HomeController.favoriteUser[index];
                                return UnconstrainedBox(
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(Routes.DETAIL,
                                                arguments:
                                                    favoriteUser.barangId),
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: Card(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  favoriteUser.gambar,
                                                  width: 80,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          favoriteUser
                                                              .namaBarang,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      favoriteUser.kategori,
                                                      style: const TextStyle(
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller.formatRupiah(
                                                          favoriteUser.harga
                                                              .toDouble()),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.orange[800],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          onPressed: () => showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 20,
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                content: const Text(
                                                  textAlign: TextAlign.center,
                                                  "Hapus daftar ini dari favorite?",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text(
                                                      "Tidak",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      HomeController
                                                          .deleteFavoriteUser(
                                                              favoriteUser
                                                                  .barangId);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Ya",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.orange[800],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          icon: Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.orange[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: HomeController.favoriteUser.length,
                            ),
                          ],
                        ),
            ],
          )),
    );
  }
}
