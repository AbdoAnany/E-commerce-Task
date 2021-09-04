import 'package:abdelrahman/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../theme.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      color: kWhiteColor,
      child: Center(
        child: Container(
          height: 100,
          child: Icon(Icons.ac_unit),
        ),
      ),
    ));
  }
}
