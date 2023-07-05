import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/auth/login/controller/login_controller.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorWhite,
        // 6495ED (CornflowerBlue ), 00BFFF(DeepSkyBlue), 87CEFA(LightSkyBlue )
        // appBar: AppBar(
        //   title: Text(appName.toUpperCase(), style: TextStyles.kH24WhiteBold),
        //   automaticallyImplyLeading: false,
        //   centerTitle: false,
        //   backgroundColor: kColorPrimary,
        // ),
        body: Stack(
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                height: 450,
                width: 450,
                child: SvgPicture.asset(
                  kImgLogin,
                  excludeFromSemantics: true,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: Get.height * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                    child: Text(kHelloArtLovers,
                        style: TextStyles.kH24PrimaryBold),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        /// admin container
                        Container(
                          margin: EdgeInsets.only(
                              left: 32, right: 32, top: Get.height * .5),
                          decoration: BoxDecoration(
                            color: kColorWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: kColorPrimary),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: kColorWhite,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: kColorPrimary),
                                ),
                                child: SvgPicture.asset(kIconGoogle),
                                margin: const EdgeInsets.all(8),
                              ),
                              SizedBox(
                                width: Get.width * .55,
                                child: Text(kAdmin.toUpperCase(),
                                    style: TextStyles.kH24PrimaryBold,
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: Get.width * .35,
                                height: .5,
                                margin: EdgeInsets.only(left: 16),
                                color: kColorGray98,
                              ),
                              Text(kOr.toUpperCase(),
                                  style: TextStyles.kH18Grey98Bold400),
                              Container(
                                width: Get.width * .35,
                                height: .5,
                                margin: EdgeInsets.only(right: 16),
                                color: kColorGray98,
                              ),
                            ],
                          ),
                        ),

                        /// visitor container
                        GestureDetector(
                          onTap: () {
                            controller.loginAsViewer();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 32, right: 32, top: 20),
                            decoration: BoxDecoration(
                              color: kColorPrimary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: kColorPrimary),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: kColorWhite,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: kColorPrimary),
                                  ),
                                  child: SvgPicture.asset(kIconGoogle),
                                  margin: const EdgeInsets.all(8),
                                ),
                                SizedBox(
                                  width: Get.width * .55,
                                  child: Text(kVisitor.toUpperCase(),
                                      style: TextStyles.kH24WhiteBold,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
