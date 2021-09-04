import 'package:abdelrahman/size_config.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class FavouriteScreen extends StatelessWidget {
  static String routeName = "/favourite";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(backgroundColor:kWhiteColor ,elevation: 0,
        title: Text(
          "Favourite List",style: TextStyle(color: kPrimaryColor,fontSize: 30,fontWeight: FontWeight.bold),

        ),
      ),
      body: Body(),
    );
  }
}
