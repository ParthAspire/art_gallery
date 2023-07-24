import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';

Widget commonAuthTextField(
    {required TextEditingController controller,
      required String hintText,
      // required String labelText,
      Widget? preFixIcon,
      String? preFixText,
      FocusNode? focusNode,
      TextInputType keyboardType = TextInputType.text,
      Function(String)? onChanged,
      int maxLength = 50,
      double elevation = 8.0,
      int maxLines = 1,
      double contentPadding = 15,
      Function? onTap,
      bool enabled = true,
      bool readOnly = false,
      //    Function(String)? validator,
      bool prefixIconVisible = true}) {
  return Material(
    elevation: elevation,
    shadowColor: kColorBlack,
    borderRadius: BorderRadius.circular(kBorderRadius),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      //  validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled,
      // autofocus: true,
      focusNode: focusNode,
      onChanged: onChanged,
      cursorColor: kColorBlack,
      readOnly: readOnly,
      onTap: () {
        try {
          onTap!();
        } catch (e) {
          debugPrint('$e');
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding),
        hintText: hintText,
        // labelText: labelText,
        labelStyle: TextStyles.kH14BlackBold700,
        hintStyle: TextStyles.kH14Grey6ABold400,
        prefixIcon: prefixIconVisible ? preFixIcon : null,
        prefixText: preFixText,
        counterText: '',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: kColorBlack, width: 1),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorBlack, width: 1),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorBlack, width: 1),
            borderRadius: BorderRadius.circular(kBorderRadius)),
      ),
    ),
  );
}
