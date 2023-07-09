import 'package:art_gallery/app/screens/auth/login/controller/login_controller.dart';
import 'package:art_gallery/app/screens/dashboard/admin/add_product/controller/add_product_controller.dart';
import 'package:art_gallery/app/screens/dashboard/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:art_gallery/app/screens/dashboard/home/base/controller/home_base_controller.dart';
import 'package:art_gallery/app/screens/dashboard/product/product_details/controller/product_details_controller.dart';
import 'package:art_gallery/app/screens/dashboard/settings/base/controller/settings_base_controller.dart';
import 'package:art_gallery/app/screens/dashboard/settings/personal_details/controller/personal_details_controller.dart';
import 'package:art_gallery/app/screens/dashboard/settings/users_listing/controller/users_listing_controller.dart';
import 'package:art_gallery/app/screens/on_boarding/controller/on_boarding_controller.dart';
import 'package:get/get.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<OnBoardingController>(() => OnBoardingController(),
        fenix: true);
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);

    Get.lazyPut<SettingsBaseController>(() => SettingsBaseController(),
        fenix: true);
    Get.lazyPut<HomeBaseController>(() => HomeBaseController(), fenix: true);
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController(),
        fenix: true);
    Get.lazyPut<PersonalDetailsController>(() => PersonalDetailsController(),
        fenix: true);

    /// admin
    Get.lazyPut<AddProductController>(() => AddProductController(),
        fenix: true);
    Get.lazyPut<UsersListingController>(() => UsersListingController(),
        fenix: true);
  }
}
