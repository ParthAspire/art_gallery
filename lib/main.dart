import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/controller/controller_bindings.dart';
import 'package:art_gallery/app/screens/auth/login/view/login_view.dart';
import 'package:art_gallery/app/screens/dashboard/bottom_nav/view/bottom_nav_screen.dart';
import 'package:art_gallery/app/screens/on_boarding/view/on_boarding_screen.dart';
import 'package:art_gallery/app/screens/splash_screen/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ),
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
        ), GetPage(
          name: kRouteOnBoardingScreen,
          page: () => OnBoardingScreen(),
        ),
        GetPage(
          name: kRouteBottomNavScreen,
          page: () => BottomNavScreen(),
        ),
      ],
    );
  }
}
