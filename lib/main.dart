import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/controller/controller_bindings.dart';
import 'package:art_gallery/app/screens/auth/login/view/login_view.dart';
import 'package:art_gallery/app/screens/dashboard/admin/add_product/view/add_product_screen.dart';
import 'package:art_gallery/app/screens/dashboard/bottom_nav/view/bottom_nav_screen.dart';
import 'package:art_gallery/app/screens/dashboard/home/base/view/home_base_screen.dart';
import 'package:art_gallery/app/screens/dashboard/product/full_screen_image/view/full_screen_image.dart';
import 'package:art_gallery/app/screens/dashboard/product/product_details/view/product_details_screen.dart';
import 'package:art_gallery/app/screens/dashboard/settings/personal_details/view/personal_details_screen.dart';
import 'package:art_gallery/app/screens/dashboard/settings/users_listing/view/user_listing_screen.dart';
import 'package:art_gallery/app/screens/on_boarding/view/on_boarding_screen.dart';
import 'package:art_gallery/app/screens/splash_screen/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: kColorBlack, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: kColorBlack,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: kColorBlack,
            ),
          )),
      initialBinding: ControllerBindings(),
      home: SplashScreen(),
      routingCallback: (value) {
        AppConstants().currentRoute = value?.current ?? '';
        debugPrint(' ############# routing callback : ${value?.current}');
      },
      getPages: [
        GetPage(
          name: kRouteLoginScreen,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: kRouteOnBoardingScreen,
          page: () => OnBoardingScreen(),
        ),
        GetPage(
          name: kRouteBottomNavScreen,
          page: () => BottomNavScreen(),
        ),
        GetPage(
          name: kRouteHomeBaseScreen,
          page: () => HomeBaseScreen(),
        ),
        GetPage(
          name: kRouteProductDetailsScreen,
          page: () => ProductDetailsScreen(),
        ),
        GetPage(
          name: kRoutePersonalDetailsScreen,
          page: () => PersonalDetailsScreen(),
        ),
        GetPage(
          name: kRouteFullScreenImage,
          page: () => FullScreenImage(),
        ),

        /// admin
        GetPage(
          name: kRouteAddProductScreen,
          page: () => AddProductScreen(),
        ),
        GetPage(
          name: kRouteUsersListingScreen,
          page: () => UsersListingScreen(),
        ),
      ],
    );
  }
}
