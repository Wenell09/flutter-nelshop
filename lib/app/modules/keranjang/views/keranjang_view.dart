import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});
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
          "Keranjang",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                child: (HomeController.homeUserId.value.isEmpty)
                    ? const Center(
                        child: Text(
                          "Belum ada daftar keranjang",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView(
                        children: [
                          (HomeController.keranjangUser.isEmpty)
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    const Text(
                                      textAlign: TextAlign.center,
                                      "Belum ada daftar keranjang",
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
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                top: 20,
                                                bottom: 20,
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              content: const Text(
                                                textAlign: TextAlign.center,
                                                "Hapus semua dari keranjang?",
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
                                                    controller
                                                        .deleteShoppingCartUser(
                                                            "");
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Ya",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange[800],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          margin:
                                              const EdgeInsets.only(left: 25),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0375,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.delete_forever_outlined,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final keranjangUser =
                                            HomeController.keranjangUser[index];
                                        return UnconstrainedBox(
                                          child: Stack(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            Routes.DETAIL,
                                                            arguments:
                                                                keranjangUser
                                                                    .barangId),
                                                highlightColor:
                                                    Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                child: Card(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.13,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.network(
                                                          keranjangUser.gambar,
                                                          width: 80,
                                                          height:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  keranjangUser
                                                                      .namaBarang,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              keranjangUser
                                                                  .kategori,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                              ),
                                                            ),
                                                            Text(
                                                              controller.formatRupiah(
                                                                  keranjangUser
                                                                      .totalHarga
                                                                      .toDouble()),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .orange[
                                                                    800],
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () =>
                                                          showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                              bottom: 20,
                                                            ),
                                                            actionsAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            content: const Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              "Hapus daftar ini dari keranjang?",
                                                              style: TextStyle(
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child:
                                                                    const Text(
                                                                  "Tidak",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  controller.deleteShoppingCartUser(
                                                                      keranjangUser
                                                                          .keranjangId);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  "Ya",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .orange[
                                                                        800],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .delete_forever_outlined,
                                                        color:
                                                            Colors.orange[800],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.035,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () => controller
                                                                .kurangQuantity(
                                                              1,
                                                              keranjangUser
                                                                  .quantity,
                                                              keranjangUser
                                                                  .keranjangId,
                                                              keranjangUser
                                                                  .harga,
                                                            ),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.075,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          50),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          50),
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "--",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            keranjangUser
                                                                .quantity
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () => controller
                                                                .tambahQuantity(
                                                              1,
                                                              keranjangUser
                                                                  .quantity,
                                                              keranjangUser
                                                                  .keranjangId,
                                                              keranjangUser
                                                                  .harga,
                                                            ),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.075,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          50),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          50),
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "+",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:
                                          HomeController.keranjangUser.length,
                                    ),
                                  ],
                                ),
                        ],
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.178,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(
                        () => Text(
                          (HomeController.homeUserId.value.isEmpty)
                              ? "Rp.0"
                              : controller.formatRupiah(
                                  HomeController.totalBayar.value.toDouble()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => (HomeController.homeUserId.value.isEmpty)
                        ? Get.defaultDialog(
                            title: "Error!",
                            middleText:
                                "tidak ada daftar barang yang ingin dibayar",
                          )
                        : (HomeController.totalBayar.value == 0)
                            ? Get.defaultDialog(
                                title: "Error!",
                                middleText:
                                    "pastikan ada barang yang ingin dibayar",
                              )
                            : Navigator.of(context)
                                .pushNamed(Routes.PEMBAYARAN),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.orange[800],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Pembayaran",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
