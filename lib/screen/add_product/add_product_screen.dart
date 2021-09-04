import 'package:abdelrahman/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class AddProductScreen extends StatelessWidget {
  static String routeName = "/add_product";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Body(),
    );
  }
}
