import 'package:get/get.dart';

import '../modules/alamat/bindings/alamat_binding.dart';
import '../modules/alamat/views/alamat_view.dart';
import '../modules/bottomNavBar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottomNavBar/views/bottom_nav_bar_view.dart';
import '../modules/brands/bindings/brands_binding.dart';
import '../modules/brands/views/brands_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/detailBrands/bindings/detail_brands_binding.dart';
import '../modules/detailBrands/views/detail_brands_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kategori/bindings/kategori_binding.dart';
import '../modules/kategori/views/kategori_view.dart';
import '../modules/keranjang/bindings/keranjang_binding.dart';
import '../modules/keranjang/views/keranjang_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myAccount/bindings/my_account_binding.dart';
import '../modules/myAccount/views/my_account_view.dart';
import '../modules/pembayaran/bindings/pembayaran_binding.dart';
import '../modules/pembayaran/views/pembayaran_view.dart';
import '../modules/pilihAlamat/bindings/pilih_alamat_binding.dart';
import '../modules/pilihAlamat/views/pilih_alamat_view.dart';
import '../modules/searchBarang/bindings/search_barang_binding.dart';
import '../modules/searchBarang/views/search_barang_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.BRANDS,
      page: () => const BrandsView(),
      binding: BrandsBinding(),
    ),
    GetPage(
      name: _Paths.MY_ACCOUNT,
      page: () => const MyAccountView(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: _Paths.KATEGORI,
      page: () => const KategoriView(),
      binding: KategoriBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BRANDS,
      page: () => const DetailBrandsView(),
      binding: DetailBrandsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG,
      page: () => const KeranjangView(),
      binding: KeranjangBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_BARANG,
      page: () => const SearchBarangView(),
      binding: SearchBarangBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT,
      page: () => const AlamatView(),
      binding: AlamatBinding(),
    ),
    GetPage(
      name: _Paths.PILIH_ALAMAT,
      page: () => const PilihAlamatView(),
      binding: PilihAlamatBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
