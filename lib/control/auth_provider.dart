import 'dart:io';
import 'dart:math';

import 'package:abdelrahman/model/Cart.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int quantity = 0;
double total = 0.00;

class MyProvider extends ChangeNotifier {
  List<Product>? favouriteList = [];
  List<Product>? productList = [];
  DbHelper _dbHelper = DbHelper();

  getProductList() async {
    productList = (await _dbHelper.allDateItem()).cast<Product>();
    notifyListeners();
    return productList;
  }

  getFavouriteLists() {
    getProductList();
    productList!.forEach((element) {
      if (element.isPopular == 1) favouriteList!.add(element);
      notifyListeners();
    });
    return favouriteList!.length;
  }

  Future showAlert(String error, myContext) async {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: myContext,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  error,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        });
  }
}
