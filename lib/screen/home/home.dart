import 'dart:io';

import 'package:abdelrahman/components/dismissible.dart';
import 'package:abdelrahman/components/product_card.dart';
import 'package:abdelrahman/control/Product_service.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Cart.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:abdelrahman/routes.dart';
import 'package:abdelrahman/screen/add_product/add_product_screen.dart';
import 'package:abdelrahman/screen/cart/cart_screen.dart';
import 'package:abdelrahman/screen/favourite/favourite_screen.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../size_config.dart';
int countFav = 0;

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Product? product;
  late File file;
  DbHelper _dbHelper = DbHelper();
  Future? fav;
  Future? cart;

  ProductsNotifier? products;
  int countFav = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = Provider.of<ProductsNotifier>(context, listen: false);
    cart=  getProdProducts(products!);
    fav=  getFavouriteProducts(products!);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return  RefreshIndicator(
        onRefresh: () => () async {
          getProdProducts(products!);
          getFavouriteProducts(products!);
        }(),
        child: FutureBuilder(
            future: Future.value(
                [_dbHelper.allDateItem(),fav]),
            builder: (context, snapshot) {
              products!.addListener(() {
                setState(() {
                  demoCarts.length;
                });


              });
              return SafeArea(child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: kWhiteColor,

                body: Column(
                  children: [
                    SizedBox(height: 10),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Flexible(
                            flex: 8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: kGrayColor.withOpacity(.5),
                                  size: 30,
                                ),
                                labelText: 'Search',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 25.0),
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: kWhiteColor,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: kWhiteColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RawMaterialButton(
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, FavouriteScreen.routeName);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Icon(
                                        Icons.favorite,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 7,
                                          minHeight: 7,
                                        ),
                                        child: Text(
                                          '${products!.favouriteList.length}',
                                          style: TextStyle(
                                              color: products!.favouriteList.length != 0
                                                  ? Colors.red
                                                  : Colors.transparent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RawMaterialButton(
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, CartScreen.routeName,arguments: products);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 7,
                                          minHeight: 7,
                                        ),
                                        child: Text(
                                          '${demoCarts.length}',
                                          style: TextStyle(
                                              color: demoCarts.isNotEmpty
                                                  ? Colors.red
                                                  : Colors.transparent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Flexible(
                        flex: 9,fit: FlexFit.tight,
                        child: ListView.builder(
                            itemCount: products!.productsList.length,
                            itemBuilder: (context, index) {
                              product = products!.productsList[index];
                              return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                  height: SizeConfig.screenHeight! / 5,
                                  width: SizeConfig.screenWidth! * .8,
                                  child: ProductCard(
                                    product: product,
                                    products: products,)
                              );
                            }))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, AddProductScreen.routeName);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),);
            }));
  }


}
Widget buildSwipeActionLeft() => Container(
  alignment: Alignment.centerLeft,
  padding: EdgeInsets.symmetric(horizontal: 20),
  color: kPrimaryColor,
  child: Icon(Icons.add_shopping_cart_outlined, color: Colors.white, size: 32),
);

Widget buildSwipeActionRight() => Container(
  alignment: Alignment.centerRight,
  padding: EdgeInsets.symmetric(horizontal: 20),
  color: Colors.red,
  child: Icon(Icons.favorite, color: Colors.white, size: 32),
);