import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:art_gallery/app/widgets/water_drop_bottom_nav/src/bar_item.dart';
import 'package:art_gallery/app/widgets/water_drop_bottom_nav/src/build_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("Page 10"),
            ),
            Container(
              alignment: Alignment.center,
              child: Text("Page 2"),
            ),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: Colors.white,
          waterDropColor: kColorPrimary,
          onItemSelected: (index) {
            controller.selectedIndex.value = index;
          },
          selectedIndex: controller.selectedIndex.value,
          barItems: [
            BarItem(
              filledIcon: kIconHomeFilled,
              outlinedIcon: kIconHomeUnFilled,
              imgHeight: 38,
            ),
            BarItem(
              filledIcon: kIconProfileFilled,
              outlinedIcon: kIconProfileUnFilled,
            )
          ],
        ),
      );
    });
  }
}
