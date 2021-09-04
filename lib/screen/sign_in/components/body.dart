import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  // var pro = ChangeNotifierProvider((ref) => AuthProvider());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Container(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Text(
                    "Sign in to your account",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),

                SizedBox(height: 20.0),

                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Do not have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "Create it!",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                //SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //     SocalCard(icon: "assets/icons/facebook-2.svg", press: () {},),
                  ],
                ),
                SizedBox(height: getScreenHeight(20)),
                SizedBox(height: getScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showNoInternetSnack(
    GlobalKey<ScaffoldState> _scaffoldKey,
  ) {
    return _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 7000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "That Part nor Work",
                //   style: normalFont(null, null),
              ),
            ),
            Icon(
              Icons.info,
              color: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
