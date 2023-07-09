import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/screens/dashboard/settings/personal_details/controller/personal_details_controller.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/widgets/common_app_bar.dart';
import 'package:art_gallery/app/widgets/common_textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsScreen extends GetView<PersonalDetailsController> {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleStr: kPersonalDetails,
        onBackTap: () {
          Get.back();
        },
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(kHorizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: CachedNetworkImage(
                    imageUrl: controller.userData.value.photoUrl ?? '',
                    height: 150,
                    fit: BoxFit.fill,
                    width: 150,
                    progressIndicatorBuilder: (context, url, progress) {
                      return showLoader(bgColor: Colors.transparent);
                    },
                    errorWidget: (context, url, error) {
                      return showLoader(bgColor: Colors.transparent);
                      // return SvgPicture.asset(kImgDefaultProduct);
                    },
                  ),
                ),
              ),
              IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: commonTextField(
                    controller: controller.personNameController,
                    hintText: kPersonName,
                    labelText: kPersonName,
                  ),
                ),
              ),
              IgnorePointer(
                child: commonTextField(
                  controller: controller.personEmailController,
                  hintText: kEmail,
                  labelText: kEmail,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
