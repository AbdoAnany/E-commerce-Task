import 'dart:collection';

import 'package:abdelrahman/model/Product.dart';
import 'package:flutter/foundation.dart';

import 'Product_service.dart';

class ProductsNotifier extends ChangeNotifier {
  List<Product> _productList = [];
  List<Product> _favouriteList = [];
  int countFavourite = 0;

  UnmodifiableListView<Product> get productsList =>
      UnmodifiableListView(_productList);
  UnmodifiableListView<Product> get favouriteList =>
      UnmodifiableListView(_favouriteList);


  void notife(){

    notifyListeners();
  }

  set productsList(List<Product> ProductList) {
    _productList = ProductList;
    notifyListeners();
  }

  set favouriteList(List<Product> ProductList) {
    _favouriteList = ProductList;
    countFavourite = _favouriteList.length;
    notifyListeners();
  }



}
