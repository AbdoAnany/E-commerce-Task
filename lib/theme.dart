import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFA2359A1);
const kWhiteColor = Color(0xFFE6EEF1);
const kBlackColor = Color(0xFF0F110D);

const kGrayColor = Color(0xFF5C5C5C);
const kTextColor = Color(0xFF757575);

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    accentColor: Colors.blue,
    snackBarTheme: SnackBarThemeData(
        actionTextColor: Colors.white, backgroundColor: kPrimaryColor),
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    primaryIconTheme: IconThemeData(color: Color(0xFA2359A1)),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: kTextColor),
    //  gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kPrimaryColor,
    elevation: 5,
    centerTitle: true,
    shadowColor: Colors.black,
    brightness: Brightness.light,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}

class NameValiditor {
  static String? validate(String? val) {
    print(val);
    if (val!.isEmpty) {
      return "Enter your name";
    } else if (val.length < 2) {
      return "Name has to be atleast 2 characters";
    } else if (val.length > 20) {
      return "Name is too long";
    } else {
      return '';
    }
  }
}

class EmailValiditor {
  static String? validate(String? val) {
    print(val);
    if (!val!.contains("@") || !val.contains(".")) {
      return "Enter a valid Email address";
    } else if (val.isEmpty) {
      return "Enter your Email address";
    } else {
      return '';
    }
  }
}

class PasswordValiditor {
  static String? validate(String? val) {
    // Pattern pattern = r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    // RegExp regex = RegExp(pattern);
    print(val);
    if (val!.isEmpty) {
      return "Enter a password";
    } else if (val.length < 6) {
      return "Password not strong enough";
    } else {
      return '';
    }
  }
}

class PhoneNumberValiditor {
  static String? validate(String? val) {
    print(val);
    if (val!.length < 15) {
      return "Enter a valid phone number";
    } else {
      return '';
    }
  }
}
