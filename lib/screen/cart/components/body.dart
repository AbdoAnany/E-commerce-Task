import 'package:abdelrahman/components/image_card.dart';
import 'package:abdelrahman/components/primary_button.dart';
import 'package:abdelrahman/control/Product_service.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Cart.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:abdelrahman/screen/details/details_screen.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int cost = 0;

  Map<String, dynamic> addressList = {};
  DbHelper _dbHelper = DbHelper();

  ProductsNotifier? products;
  void addQty(index) {
    setState(() {
      if (demoCarts[index].product!.colors! >
          demoCarts[index].product!.rating!) {
        setState(() {
          demoCarts[index].product!.colors = demoCarts[index].product!.rating!;
          billTotal();
        });
      } else if (demoCarts[index].product!.colors! <
          demoCarts[index].product!.rating!) {
        setState(() {
          demoCarts[index].product!.colors =
              demoCarts[index].product!.colors! + 1;
          billTotal();
        });
      }
    });
  }

  void subQty(index) {
    setState(() {
      if (demoCarts[index].product!.colors! > 1) {
        setState(() {
          demoCarts[index].product!.colors =
              demoCarts[index].product!.colors! - 1;
          billTotal();
        });
      } else if (demoCarts[index].product!.colors! <= 1) {
        setState(() {
          demoCarts[index].product!.colors = 1;
          billTotal();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    total = 0;
    products = ModalRoute.of(context)!.settings.arguments as ProductsNotifier?;

    demoCarts.forEach((element) {
      total = total + element.product!.price! * element.product!.colors!;
    });

    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
              child: ListView.builder(
                itemCount: demoCarts.length,
                itemBuilder: (context, index) {
                  if (demoCarts[index].numOfItem! > 0)
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: UniqueKey(),
                          // Key(demoCarts[index].product.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            demoCarts.removeAt(index);
                            setState(() {
                              products!.notife();
                            });
                          },
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(Icons.delete),
                              ],
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DetailsScreen.routeName,
                                  arguments: ProductDetailsArguments(
                                     products, (demoCarts[index].product!)));
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,

                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                        //    padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ImageCard(
                                          image:
                                              demoCarts[index].product!.image!,
                                        )),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          demoCarts[index].product!.title!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          maxLines: 2,
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 10),
                                        Text.rich(
                                          TextSpan(
                                            text:
                                                "\$${demoCarts[index].product!.price!.toStringAsFixed(2)} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: kPrimaryColor),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      " x${demoCarts[index].product!.colors!}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                Spacer(),
                                demoCarts[index].product!.rating! != 0
                                    ? Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: kWhiteColor,
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: getScreenHeight(30),
                                                  width: getScreenWidth(30),
                                                  child: RawMaterialButton(
                                                    onPressed: () {
                                                      subQty(index);
                                                    },
                                                    child: demoCarts[index]
                                                                .product!
                                                                .colors !=
                                                            0
                                                        ? Icon(
                                                            Icons.remove,
                                                            color:
                                                                kPrimaryColor,
                                                            size: 25.0,
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 5.0,
                                                    left: 5.0,
                                                  ),
                                                  child: Text(
                                                    demoCarts[index]
                                                        .product!
                                                        .colors
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: kBlackColor),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2.0,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: kPrimaryColor,
                                                    ),
                                                    height: getScreenHeight(33),
                                                    width: getScreenWidth(33),
                                                    child: RawMaterialButton(
                                                      onPressed: () {
                                                        addQty(index);
                                                      },
                                                      child: demoCarts[index]
                                                                  .product!
                                                                  .colors !=
                                                              demoCarts[index]
                                                                  .product!
                                                                  .rating!
                                                          ? Icon(
                                                              Icons.add,
                                                              color:
                                                                  kWhiteColor,
                                                              size: 25.0,
                                                            )
                                                          : Text(
                                                              'MAX',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      kWhiteColor),
                                                            ),
                                                    )),
                                              ]),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ));

                  return SizedBox();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: getScreenWidth(15),
                horizontal: getScreenWidth(30),
              ),
              // height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 2,
                    color: Color(0xFF3D3B3B).withOpacity(0.2),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text:
                              "${double.parse((total.toStringAsFixed(2)))} EPG",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
                    child: PrimaryButton(
                      title: "Complete Order",
                      onPressed: () {
                        demoCarts.forEach((element) {
                          if (element.product!.rating! - element.product!.colors! <= 0) {
                            element.product!.rating = 0;
                            element.product!.colors = 0;
                          }

                          if (element.product!.rating! -  element.product!.colors! > 0)
                            element.product!.rating = element.product!.rating! - element.numOfItem!;
                          element.product!.colors = 0;
                          _dbHelper.updateDateItem(element.product!);
                          print(element.product!.rating!);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Order Sending')));

                        setState(() {
                          demoCarts.clear();
                          getProdProducts(products!);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: getScreenHeight(10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(

      title: Column(
        children: [
          Text(
            "Shopping Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "${demoCarts.length} item ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
