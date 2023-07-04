import 'package:art_gallery/app/screens/auth/login/controller/login_controller.dart';
import 'package:art_gallery/app/screens/dashboard/bottom_nav/controller/bottom_nav_controller.dart';
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
  }
}
