import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';

snackBarWidget(BuildContext context, String msg) {
  var snackBar = SnackBar(
    content: Text(msg, style: TextStyles.kH16WhiteBold700),
    backgroundColor: kColorBlack,
    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 28),
    // action: SnackBarAction(
    //   label: 'Undo',
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
