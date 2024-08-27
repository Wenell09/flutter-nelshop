import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/search_barang_controller.dart';

class SearchBarangView extends GetView<SearchBarangController> {
  const SearchBarangView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: Container(),
          backgroundColor: Colors.black,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: IconButton(
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(
                        () => TextField(
                          controller: controller.inputSearch,
                          onChanged: (value) {
                            controller.searchBarang(value);
                            if (controller.inputSearch.text.isEmpty) {
                              controller.isSearch.value = false;
                            } else {
                              controller.isSearch.value = true;
                            }
                          },
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.black,
                            ),
                            suffixIcon: (controller.isSearch.value)
                                ? IconButton(
                                    onPressed: () => controller.resetInput(),
                                    icon: const Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  )
                                : const SizedBox(),
                            border: InputBorder.none,
                            hintText: "Cari handphone, laptop, dll.",
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              overflow: TextOverflow.ellipsis,
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
        ),
      ),
      body: Obx(
        () => (controller.isLoading.value)
            ? const ShimmerLoading()
            : ListView(
                children: [
                  const SizedBox(
                    height: 10,
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
