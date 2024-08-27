import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/detail_brands_controller.dart';

class DetailBrandsView extends StatelessWidget {
  const DetailBrandsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailBrandsController>(
      global: false,
      init: DetailBrandsController(),
      builder: (controller) => Scaffold(
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
          title: Obx(() => Text(
                controller.titleBrand.value,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Obx(() => (controller.isLoading.value)
            ? const ShimmerLoading()
            : ListView(
                children: [
                  const SizedBox(
                    height: 5,
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
                  ),
                ],
              )),
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
        const SizedBox(
          height: 5,
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
