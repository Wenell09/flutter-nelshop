import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/models/city_model.dart';
import 'package:flutter_nelshop/app/data/models/province_model.dart';
import 'package:flutter_nelshop/app/modules/alamat/controllers/alamat_controller.dart';
import 'package:get/get.dart';

class AlamatView extends GetView<AlamatController> {
  const AlamatView({super.key});
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
          "Tambah Alamat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 17),
              controller: controller.inputNama,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                border: InputBorder.none,
                hintText: "Isi nama penerima",
              ),
              onChanged: (value) {
                controller.validasi();
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 17),
              controller: controller.inputNomorHp,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                border: InputBorder.none,
                hintText: "Isi no handphone",
              ),
              onChanged: (value) {
                controller.validasi();
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              keyboardType: TextInputType.streetAddress,
              style: const TextStyle(fontSize: 17),
              controller: controller.inputAlamat,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                border: InputBorder.none,
                hintText: "Isi alamat rumah",
              ),
              onChanged: (value) {
                controller.validasi();
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Province(controller: controller),
          City(
            controller: controller,
            provinceID: controller.provinceId.value,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 17),
              controller: controller.inputKodePos,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                border: InputBorder.none,
                hintText: "Isi kode pos rumah",
              ),
              onChanged: (value) {
                controller.validasi();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => InkWell(
              onTap: () {
                controller.tambahAlamat();
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: (controller.hiddenSave.value)
                      ? Colors.grey
                      : Colors.orange[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Simpan Alamat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Province extends StatelessWidget {
  final AlamatController controller;
  const Province({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownSearch<ProvinceModel>(
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Masukkan Provinsi",
            labelText: "Provinsi",
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
        asyncItems: (text) => controller.getProvince(),
        itemAsString: (item) => item.province,
        onChanged: (value) {
          if (value != null) {
            controller.provinceId.value = value.provinceId;
            controller.provinceName.value = value.province;
          } else {
            controller.provinceId.value = "";
            controller.provinceName.value = "";
          }
          controller.validasi();
        },
      ),
    );
  }
}

class City extends StatelessWidget {
  final AlamatController controller;
  final String provinceID;
  const City({
    super.key,
    required this.controller,
    required this.provinceID,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownSearch<CityModel>(
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Kota/Kabupaten",
            labelText: "Kota/Kabupaten",
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
        asyncItems: (text) => controller.getCity(provinceID),
        itemAsString: (item) => "${item.type} ${item.cityName}",
        onChanged: (value) {
          if (value != null) {
            controller.cityId.value = value.cityId;
            controller.cityName.value = value.cityName;
          } else {
            controller.cityId.value = "";
            controller.cityName.value = "";
          }
          controller.validasi();
        },
      ),
    );
  }
}
