import 'package:abdelrahman/screen/cart/cart_screen.dart';
import 'package:abdelrahman/screen/details/details_screen.dart';
import 'package:abdelrahman/screen/favourite/favourite_screen.dart';
import 'package:abdelrahman/screen/home/home.dart';
import 'package:abdelrahman/screen/sign_in/sign_in_screen.dart';
import 'package:abdelrahman/screen/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

import 'screen/add_product/add_product_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AddProductScreen.routeName: (context) => AddProductScreen(),
  FavouriteScreen.routeName: (context) => FavouriteScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
};

void goto(context, screen) {
  Navigator.pushNamed(context, screen.routeName);
}
