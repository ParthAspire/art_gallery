import 'package:art_gallery/app/common/color_constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite, // 6495ED (CornflowerBlue ), 00BFFF(DeepSkyBlue), 87CEFA(LightSkyBlue )
      appBar: AppBar(
        backgroundColor: Color(0xFF66A5AD), // C4DFE6
      ),
    );
  }
}
