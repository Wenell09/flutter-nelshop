import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat datang di',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nelshop',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Obx(
              () => IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.FAVORITE),
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.favorite_outline_outlined,
                      color: Colors.white,
                      size: 27,
                    ),
                    (HomeController.favoriteUser.isEmpty)
                        ? const SizedBox()
                        : Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange[300],
                              radius: 7,
                              child: Text(
                                HomeController.favoriteUser.length.toString(),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                  ],
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
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () =>
                  Navigator.of(context).pushNamed(Routes.SEARCH_BARANG),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        "Cari handphone, laptop, dll.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
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
                  UnconstrainedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      height: MediaQuery.of(context).size.height * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PageView.builder(
                              physics: const ScrollPhysics(),
                              controller: controller.pageController,
                              onPageChanged: controller.onPageChanged,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        (index) == 0
                                            ? "assets/banner1.jpg"
                                            : index == 1
                                                ? "assets/banner2.jpg"
                                                : "assets/banner3.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              itemCount: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 10),
                                  child: AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    width:
                                        (controller.currentPage.value == index)
                                            ? 30
                                            : 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: (controller.currentPage.value ==
                                              index)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Pilih kategori",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final kategori = controller.kategori[index];
                          return Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(Routes.KATEGORI, arguments: {
                                      "kategoriId": kategori.kategoriId,
                                      "title": kategori.kategori
                                    }),
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: index == 0
                                            ? const Icon(
                                                Icons.phone_android,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.laptop,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    kategori.kategori,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                        itemCount: controller.kategori.length,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Produk Terlaris",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                    itemCount: 4,
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
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: UnconstrainedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: UnconstrainedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 50,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 50,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: UnconstrainedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 30,
                  color: Colors.white,
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
            ],
          ),
        )
      ],
    );
  }
}
