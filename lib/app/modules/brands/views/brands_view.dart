import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/routes/app_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/brands_controller.dart';

class BrandsView extends GetView<BrandsController> {
  const BrandsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Brands",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Obx(
          () => (controller.isLoading.value)
              ? const ShimmerLoading()
              : ListView(
                  physics: const ScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2 / 1.5,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final kategoriMerk = controller.kategoriMerk[index];

                        return InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(Routes.DETAIL_BRANDS, arguments: {
                            "title": kategoriMerk.kategoriMerk,
                            "kategoriMerkId": kategoriMerk.kategoriMerkId,
                          }),
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            child: (kategoriMerk.kategoriMerkId == "KTM02")
                                ? Stack(
                                    children: [
                                      const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.apple,
                                          size: 80,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              kategoriMerk.kategoriMerk,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          kategoriMerk.gambar,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              kategoriMerk.kategoriMerk,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                      itemCount: controller.kategoriMerk.length,
                    ),
                  ],
                ),
        ));
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
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 2 / 1.5,
            ),
            padding: const EdgeInsets.all(8.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              Card(),
              Card(),
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
