import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/kategori_controller.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({super.key});
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
        title: Text(
          controller.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(
        () => (controller.isLoading.value)
            ? const ShimmerLoading()
            : ListView(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            controller.getBarangwithMerk("");
                            controller.getTitleMerk("");
                            controller.updateSelectedIndex(0);
                          },
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.042,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: (controller.selectedIndex.value == 0)
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                "Semua kategori",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (controller.selectedIndex.value == 0)
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 70,
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final kategoriMerk =
                                  controller.kategoriMerk[index];
                              return UnconstrainedBox(
                                child: InkWell(
                                  onTap: () {
                                    controller.getBarangwithMerk(
                                        kategoriMerk.kategoriMerkId);
                                    controller.getTitleMerk(
                                        kategoriMerk.kategoriMerk);
                                    controller.updateSelectedIndex(index + 1);
                                  },
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    height: MediaQuery.of(context).size.height *
                                        0.042,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black),
                                      color: (controller.selectedIndex.value ==
                                              index + 1)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        kategoriMerk.kategoriMerk,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              (controller.selectedIndex.value ==
                                                      index + 1)
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.kategoriMerk.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      (controller.titleMerk.value.isEmpty)
                          ? "Semua kategori"
                          : controller.titleMerk.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 2.3,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final barang = controller.barang[index];
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                Routes.DETAIL,
                                arguments: barang.barangId),
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Center(
                                        child: Image.network(
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          barang.gambar,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      barang.namaBarang,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.formatRupiah(
                                          barang.harga.toDouble()),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => (HomeController
                                      .homeUserId.value.isEmpty)
                                  ? Get.defaultDialog(
                                      title: "Harap login dahulu!",
                                      middleText:
                                          "login untuk menambahkan favorite",
                                    )
                                  : (HomeController.favoriteUser.any((data) =>
                                          data.barangId == barang.barangId))
                                      ? HomeController.deleteFavoriteUser(
                                          barang.barangId)
                                      : HomeController.addFavoriteUser(
                                          barang.barangId,
                                          barang.namaBarang,
                                          barang.harga,
                                          barang.gambar,
                                          barang.kategoriId,
                                        ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 4, top: 4),
                                width:
                                    MediaQuery.of(context).size.width * 0.0875,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: Colors.orange[700],
                                ),
                                child: Center(
                                  child: Obx(
                                    () => Icon(
                                      (HomeController.favoriteUser.any((data) =>
                                              data.barangId == barang.barangId))
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: controller.barang.length,
                  )
                ],
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SizedBox(
            height: 70,
            child: ListView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Row(
                  children: List.generate(
                    4,
                    (index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: MediaQuery.of(context).size.height * 0.042,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Align(
              alignment: Alignment.topLeft,
              child: UnconstrainedBox(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 2 / 2.3,
            ),
            padding: const EdgeInsets.all(8.0),
            children: const [
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
            ],
          ),
        )
      ],
    );
  }
}
