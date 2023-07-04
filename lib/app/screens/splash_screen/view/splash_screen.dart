import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  checkUserLogin() {
    if (_auth.currentUser != null) {
      Get.offAllNamed(kRouteBottomNavScreen);
    } else {
      Get.offAllNamed(kRouteOnBoardingScreen);
    }
  }

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        checkUserLogin();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      // 6495ED (CornflowerBlue ), 00BFFF(DeepSkyBlue), 87CEFA(LightSkyBlue )
      body: Center(
        child: Text(
          appName,
          style: TextStyles.kH20WhiteBold700,
        ),
      ),
    );
  }
}
