import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/pembayaran_controller.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({super.key});
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
          "Pembayaran",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: Container(
                margin: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.PILIH_ALAMAT),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.orange[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Pilih Alamat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (PembayaranController.alamatUtama.isEmpty)
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("alamat utama kosong/belum dipilih"),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final alamatUtama =
                                  PembayaranController.alamatUtama[index];
                              return Container(
                                padding: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "Alamat Pengiriman",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      alamatUtama.namaPenerima,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      alamatUtama.noHandphone,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${alamatUtama.alamatRumah},${alamatUtama.provinsi},${alamatUtama.kotaKabupaten},${alamatUtama.kodePos}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: PembayaranController.alamatUtama.length,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Pilih Kurir",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownSearch(
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Masukkan Tipe Kurir",
                                labelText: "Tipe Kurir",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            clearButtonProps: const ClearButtonProps(
                              isVisible: true,
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                            items: const [
                              {
                                "code": "jne",
                                "name": "Jalur Nugraha Ekakurir (JNE)",
                              },
                              {
                                "code": "pos",
                                "name": "Perusahaan Opsional Surat (POS)",
                              },
                              {
                                "code": "tiki",
                                "name": "Titipan Kilat (TIKI)",
                              }
                            ],
                            itemAsString: (item) => "${item["name"]}",
                            onChanged: (value) {
                              if (value != null) {
                                controller.kurirCode.value =
                                    value["code"].toString();
                                controller.getBiayaOngkir(
                                    PembayaranController
                                        .alamatUtama[0].kotaKabupatenId,
                                    HomeController.totalBerat.value.toString());
                              } else {
                                controller.kurirCode.value = "";
                                controller.ongkir.value = 0;
                                controller.totalKeseluruhan.value =
                                    HomeController.totalBayar.value;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.2125,
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
                      "Total barang",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.formatRupiah(
                          HomeController.totalBayar.value.toDouble()),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ongkir",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller
                            .formatRupiah(controller.ongkir.value.toDouble()),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Bayar",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.formatRupiah(
                            controller.totalKeseluruhan.value.toDouble()),
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.0625,
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
    );
  }
}
