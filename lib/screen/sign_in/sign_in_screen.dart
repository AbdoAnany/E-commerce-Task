import 'package:abdelrahman/components/primary_button.dart';
import 'package:abdelrahman/screen/home/home.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../size_config.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<_SignInScreenState>();
  String? _name;
  String? _email;
  String? _phone;
  String? _error;
  bool _autoValidate = false;
  bool _isButtonDisabled = false;
  bool _obscureText = true;
  bool _isEnabled = true;
  bool remember = false;
  final List<String> errors = [];
  final RegExp emailValidatorRegExp =
  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Text(
                    "Sign in \nBy your account",
                    style: TextStyle(fontSize: 35, color: kGrayColor),
                    textAlign: TextAlign.start,
                  ),
                ),

                SizedBox(height: 20.0),

                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Do not have an account? ",
                        style: TextStyle(fontSize: 16, color: kGrayColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "Create it!",
                          style: TextStyle(fontSize: 16, color: kPrimaryColor),
                          textAlign: TextAlign.start,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                SizedBox(height: 10.0),

                //FORM
                Form(
                  key: formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: <Widget>[
                      buildNameFormField(),
                      SizedBox(height: getScreenHeight(30)),
                      buildPhoneFormField(),
                      SizedBox(height: getScreenHeight(30)),
                      buildEmailFormField(),
                      SizedBox(height: 20.0),

                      SizedBox(height: 20.0),
                      SizedBox(height: 20.0),
                      _isButtonDisabled == true
                          ? CircularProgressIndicator(
                              color: kPrimaryColor,
                            )
                          : PrimaryButton(
                              title: "Sign in",
                              onPressed: _isButtonDisabled ? null : _submit,
                            ),
                      SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          SizedBox(width: 10.0),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Forget Password ?",
                              style: TextStyle(fontSize: 16, color: kGrayColor),
                            ),
                          ),
                          Spacer(),
                          IconButton(onPressed: (){
                            setState(() {
                              remember=!remember;
                            });
                          },
                            icon:Icon(remember?Icons.check_box:Icons.check_box_outline_blank),
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            child: Text(
                              "Remember me.",
                              style: TextStyle(fontSize: 16, color: kGrayColor),
                            ),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _submit() async {
    final form = formKey.currentState;

    try {
      if (form!.validate()) {
        form.save();

        if (mounted) {
          setState(() {
            _isButtonDisabled = true;
            _isEnabled = false;
          });
        }
        if (_email == 'a@a.com')
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        if (_email != 'a@a.com')
          {   _autoValidate = true; _isButtonDisabled = false;}

      } else {
        setState(() {
          _autoValidate = true;
          _isButtonDisabled = false;
          _isEnabled = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isButtonDisabled = false;
          _isEnabled = true;
        });
      }

      print("ERRORR ==>");
      print(e);
    }
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => _email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          return null;
        } else if (emailValidatorRegExp.hasMatch(value)) {
          return null;
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          if (_email != 'a@a.com')
          {    return "Enter you email a@a.com";}
          return "Enter you email a@a.com";
          } else if (!emailValidatorRegExp.hasMatch(value)) {

          return 'Enter you Valid email a@a.com';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email (a@a.com) ",

        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => _name = newValue,
      validator: (value) {
        if (value!.isEmpty) {

          return  'empty name';
        }


      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter Your Name",

        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => _phone = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return 'empty phone number';

          } else if (value.length<6) {
          return 'phone number is short should be more 6 digit';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter your Phone",

        floatingLabelBehavior: FloatingLabelBehavior.always,
        //  suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
