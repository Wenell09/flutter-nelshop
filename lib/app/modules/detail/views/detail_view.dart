import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/detail_controller.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      global: false,
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
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
          actions: [
            Obx(
              () => IconButton(
                onPressed: () => (HomeController.homeUserId.value.isEmpty)
                    ? Get.defaultDialog(
                        title: "Harap login dahulu!",
                        middleText: "login untuk menambahkan favorite",
                      )
                    : (HomeController.favoriteUser.any(
                            (data) => data.barangId == controller.barangId))
                        ? HomeController.deleteFavoriteUser(controller.barangId)
                        : HomeController.addFavoriteUser(
                            controller.barangId,
                            controller.detailBarang[0].namaBarang,
                            controller.detailBarang[0].harga,
                            controller.detailBarang[0].gambar,
                            controller.detailBarang[0].kategoriId,
                          ),
                icon: Center(
                  child: Icon(
                    (HomeController.favoriteUser.any(
                            (data) => data.barangId == controller.barangId))
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded,
                    size: 27,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.KERANJANG),
                icon: Center(
                  child: Stack(
                    children: [
                      const Icon(
                        size: 27,
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      (HomeController.keranjangUser.isEmpty)
                          ? const SizedBox()
                          : Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange[300],
                                radius: 7,
                                child: Text(
                                  HomeController.keranjangUser.length
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Center(
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Obx(
          () => (controller.isLoading.value)
              ? const ShimmerLoading()
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final detailBarang = controller.detailBarang[index];
                            return Obx(
                              () => Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.network(
                                    detailBarang.gambar,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        detailBarang.namaBarang,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        controller.formatRupiah(
                                            detailBarang.harga.toDouble()),
                                        style: TextStyle(
                                          color: Colors.orange[800],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        "${detailBarang.stok} Stok | ${detailBarang.terjual} Terjual",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: List.generate(
                                      3,
                                      (value) => InkWell(
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () =>
                                            controller.changePage(value),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0375,
                                          decoration: (controller
                                                      .currentPage.value ==
                                                  value)
                                              ? BoxDecoration(
                                                  color: Colors.orange[800],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )
                                              : null,
                                          child: Text(
                                            (value == 0)
                                                ? "Deskripsi"
                                                : (value == 1)
                                                    ? "Spesifikasi"
                                                    : "Review",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      (controller.currentPage.value == 0)
                                          ? detailBarang.deskripsi
                                          : (controller.currentPage.value == 1)
                                              ? detailBarang.spesifikasi
                                              : "ini review nanti",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: controller.detailBarang.length,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => controller.kurangQuantity(1),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          bottomLeft: Radius.circular(50),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "--",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.quantity.value.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => controller.tambahQuantity(1),
                                    child: Container(
                                      height: double.infinity,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () => (MyAccountController
                                      .userId.value.isEmpty)
                                  ? Get.defaultDialog(
                                      title: "Harap login dahulu!",
                                      middleText:
                                          "login untuk menambahkan ke keranjang",
                                    )
                                  : controller.addToCart(
                                      controller.detailBarang[0].namaBarang,
                                      controller.detailBarang[0].harga,
                                      controller.detailBarang[0].gambar,
                                      controller.detailBarang[0].berat,
                                      controller.detailBarang[0].kategoriId),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  color: Colors.orange[800],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Tambah ke keranjang",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
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
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.38,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.07,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.0375,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 7),
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 100,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
