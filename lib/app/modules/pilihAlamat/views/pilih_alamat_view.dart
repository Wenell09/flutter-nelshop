import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/pembayaran/controllers/pembayaran_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/pilih_alamat_controller.dart';

class PilihAlamatView extends GetView<PilihAlamatController> {
  const PilihAlamatView({super.key});
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
          "Pilih alamat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            onPressed: () => Navigator.of(context).pushNamed(Routes.ALAMAT),
            icon: const Icon(
              Icons.border_color,
              size: 27,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(
        () => (PembayaranController.alamat.isEmpty)
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Daftar alamat kosong! silahkan tambah alamat di ikon pojok kanan atas',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              )
            : Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 20, right: 20),
                    children: [
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
                                actionsAlignment: MainAxisAlignment.spaceAround,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: const Text(
                                  textAlign: TextAlign.center,
                                  "Hapus semua alamat?",
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
                                      controller.deleteAlamat("");
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
                            margin: const EdgeInsets.only(left: 5),
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.0375,
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final alamat = PembayaranController.alamat[index];
                          return Obx(
                            () => Column(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    controller.changeSelected(alamat.alamatId);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        decoration: BoxDecoration(
                                          color: (controller.alamatId.value ==
                                                  alamat.alamatId)
                                              ? Colors.black
                                              : Colors.white,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              alamat.namaPenerima,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: (controller
                                                            .alamatId.value ==
                                                        alamat.alamatId)
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              alamat.noHandphone,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: (controller
                                                            .alamatId.value ==
                                                        alamat.alamatId)
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${alamat.alamatRumah},${alamat.provinsi},${alamat.kotaKabupaten},${alamat.kodePos}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: (controller
                                                              .alamatId.value ==
                                                          alamat.alamatId)
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
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
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      content: const Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "Hapus alamat ini?",
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
                                                          child: const Text(
                                                            "Tidak",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            controller
                                                                .deleteAlamat(
                                                                    alamat
                                                                        .alamatId);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Ya",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .orange[800],
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
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: PembayaranController.alamat.length,
                      ),
                    ],
                  ),
                  Obx(
                    () => Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          if (controller.isSelected.value) {
                            controller.updateAlamatUtama();
                            Navigator.of(context).pop();
                          } else {
                            null;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: (controller.isSelected.value)
                                ? Colors.orange[800]
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Pilih Alamat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
