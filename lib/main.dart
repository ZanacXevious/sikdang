import 'package:flutter/material.dart';
import 'package:sikdang/common/const/colors.dart';
import 'package:sikdang/common/view/splash_screen.dart';
import 'package:sikdang/user/view/login_screen.dart';
import 'common/component/custom_text_form_field.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
