import 'package:abdelrahman/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final width;
  final title;
  final height;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      onPressed: onPressed,
      elevation: 5.0,
      // focusElevation: 0.0,
      // highlightElevation: 0.0,
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Text(title,
          style: TextStyle(
              fontSize: 18.0,
              color: kWhiteColor,
              letterSpacing: 2,
              fontWeight: FontWeight.bold)),
    );
  }
}
