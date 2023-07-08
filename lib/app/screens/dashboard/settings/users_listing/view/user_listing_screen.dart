import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/model/user_data.dart';
import 'package:art_gallery/app/screens/dashboard/settings/users_listing/controller/users_listing_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersListingScreen extends GetView<UsersListingController> {
  const UsersListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleStr: kUsers,
        onBackTap: () {
          Get.back();
        },
      ),
      body: StreamBuilder(
        stream: FirebaseServices().fireStore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                UserData userData = UserData.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: CachedNetworkImage(
                          imageUrl: userData.photoUrl ?? '',
                          height: 50,
                          fit: BoxFit.fill,
                          width: 50,
                          progressIndicatorBuilder: (context, url, progress) {
                            return showLoader(bgColor: Colors.transparent);
                          },
                          errorWidget: (context, url, error) {
                            return showLoader(bgColor: Colors.transparent);
                            // return SvgPicture.asset(kImgDefaultProduct);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userData.name ?? '',
                                style: TextStyles.kH16BlackBold700),
                            Text(userData.email ?? '',
                                style: TextStyles.kH16Gray6ABold400),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return showLoader();
          }
        },
      ),
    );
  }
}
