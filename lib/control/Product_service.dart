import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Cart.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:flutter/material.dart';

import 'auth_provider.dart';

DbHelper _dbHelper = DbHelper();
List<Cart> demoCarts = [];
Future<List<dynamic>>? getProdProducts(
    ProductsNotifier productsNotifier) async {
  var list;
  List<Product>? _prodProductsList = [];
  list = await _dbHelper.allDateItem();
  list!.forEach((element) {
    _prodProductsList.add(Product.fromMap(element));
  });
  productsNotifier.productsList = _prodProductsList;
  return productsNotifier.productsList;
}

Future<List<dynamic>>? getFavouriteProducts(
    ProductsNotifier productsNotifier) async {
  var list;
  List<Product>? _prodProductsList = [];
  list = await _dbHelper.allDateItem();
  print('_FavouritesList');
  list!.forEach((element) {
    if (element['isPopular'] == 1)
      _prodProductsList.add(Product.fromMap(element));
  });
  productsNotifier.favouriteList = _prodProductsList;
  ProductsNotifier().countFavourite = _prodProductsList.length;
  print(productsNotifier.favouriteList.length);

  return productsNotifier.favouriteList;
}


double billTotal() {
  total = 0.00;
  demoCarts.forEach((element) {
    total = total + element.product!.price! * element.product!.colors!;
  });
  return total;
}

//Adding users' product to cart
addProductToCart(Product product, context) async {
  var flag = false;

  if (demoCarts.contains(product.id)) print(product.title);

  demoCarts.forEach((element) {
    if (element.product!.id == product.id) {
      element.numOfItem = element.product!.colors;
      _dbHelper.updateDateItem(product);
      flag = true;
    }
  });
  if (!flag) {
    demoCarts.add(
      Cart(product: product, numOfItem: product.colors),
    );
  }
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(' The Product Added to cart ')));
}

