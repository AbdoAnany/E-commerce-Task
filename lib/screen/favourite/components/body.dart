import 'dart:io';

import 'package:abdelrahman/components/product_card.dart';
import 'package:abdelrahman/control/Product_service.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:abdelrahman/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DbHelper _dbHelper = DbHelper();
  Product? product;
  ProductsNotifier? products;
  late File file;
  Future? fav;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    products = Provider.of<ProductsNotifier>(context, listen: false);
    getFavouriteProducts(products!);
    fav= getFavouriteProducts(products!);
  }

  @override
  Widget build(BuildContext context) {
    products = Provider.of<ProductsNotifier>(context);

    return
      RefreshIndicator(
        onRefresh: () => () async {
          getFavouriteProducts(products!);
    }(),
      child:
      FutureBuilder(
      initialData: [],
      future:fav ,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: products!.favouriteList.length,
          itemBuilder: (context, index) {
            product = products!.favouriteList[index];
            file = File(product!.image!);
            return Container(
              height: SizeConfig.screenHeight! / 4.5,
              width: SizeConfig.screenWidth! * .8,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ProductCard(
                product: product!,products: products,
              ),
            );
          },
        );
      },
    ));
  }
}
