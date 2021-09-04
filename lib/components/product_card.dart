import 'package:abdelrahman/components/image_card.dart';
import 'package:abdelrahman/control/Product_service.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:abdelrahman/screen/details/details_screen.dart';
import 'package:abdelrahman/screen/home/home.dart';
import 'package:abdelrahman/size_config.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dismissible.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.product, this.products,
  }) : super(key: key);
  final Product? product;
  final ProductsNotifier? products;
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void addQty() {
    setState(() {
      if (widget.product!.colors! > widget.product!.rating!) {
        widget.product!.colors = widget.product!.rating!;
      } else if (widget.product!.colors! < widget.product!.rating!) {
        setState(() {
          widget.product!.colors = widget.product!.colors! + 1;
        });
      }
    });
  }

  void subQty() {
    setState(() {
      if (widget.product!.colors != 0) {
        widget.product!.colors = widget.product!.colors! - 1;
      } else if (widget.product!.colors! < 1) {
        setState(() {
          widget.product!.colors = 0;
        });
      }
    });
  }

  DbHelper _dbHelper = DbHelper();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProdProducts(widget.products!);
  }

  @override
  Widget build(BuildContext context) {
    return DismissibleWidget(
      item: widget.product!.id,
      child: Dismissible(
        key: UniqueKey(),direction:DismissDirection.up ,secondaryBackground: buildSwipeActionLeft(),
          background: buildSwipeActionRight(),
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: ProductDetailsArguments( widget.products,  widget.product!),
            ),
            child: Container(
                margin: EdgeInsets.all(5.0),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 5),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.53),
                        offset: Offset(5, 5),
                        blurRadius: 3,
                        spreadRadius: 0),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Hero(
                              tag: widget.product!.id!,
                              child: ImageCard(
                                image: widget.product!.image!,
                              ))),
                    ),
                    Expanded(
                        flex: 6,
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          direction: Axis.vertical,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  widget.product!.title!,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: kGrayColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Divider(
                              color: kGrayColor,
                              height: 5,
                              thickness: 1,
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${widget.product!.description}",
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 14, color: kGrayColor),
                                ),
                              ),
                            ),
                            Spacer(),
                            Flexible(
                              flex: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "\$ ${widget.product!.price!.toStringAsFixed(2)}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: widget.product!.price! <
                                              widget.product!.priceBefore!
                                              ? Colors.green
                                              : kPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: widget.product!.price! <
                                    widget.product!.priceBefore!
                                    ? Text(
                                  "\$ ${widget.product!.priceBefore!.toStringAsFixed(2)}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.combine([
                                        TextDecoration.lineThrough,
                                        TextDecoration.lineThrough
                                      ]),
                                      color: kGrayColor),
                                )
                                    : SizedBox(),
                              ),
                            ),
                          ],
                        )),  widget.product!.rating! !=0?
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: kWhiteColor,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: getScreenHeight(30),
                                width: getScreenWidth(30),
                                child: RawMaterialButton(
                                  onPressed: subQty,
                                  child: widget.product!.colors != 0
                                      ? Icon(
                                    Icons.remove,
                                    color: kPrimaryColor,
                                    size: 25.0,
                                  )
                                      : SizedBox(),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  right: 5.0,
                                  left: 5.0,
                                ),
                                child: Text(
                                  widget.product!.colors.toString(),
                                  style:
                                  TextStyle(fontSize: 15, color: kBlackColor),
                                ),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kPrimaryColor,
                                  ),
                                  height: getScreenHeight(30),
                                  width: getScreenWidth(30),
                                  child: RawMaterialButton(
                                    onPressed: addQty,
                                    child: widget.product!.colors !=
                                        widget.product!.rating!
                                        ? Icon(
                                      Icons.add,
                                      color: kWhiteColor,
                                      size: 25.0,
                                    )
                                        : Text(
                                      'MAX',
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                  )),
                            ]),
                      ),
                    ):
                    Expanded(flex: 3,
                      child:   Transform.rotate(angle: 45,
                        child:    Text('Out of stock',style:
                        TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red),),),)



                  ],
                )),
          )
      ,onDismissed: (direction) => dismissItem(context, direction,),
      ),
      onDismissed: (direction) => dismissItem(context, direction,),
    );
  }

  Future<void> dismissItem(
      BuildContext context, DismissDirection direction) async {
    switch (direction) {
      case DismissDirection.endToStart:
        if (widget.product!.isPopular == 1) {
          widget.product!.isPopular = 0;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(' The Product deleted from Favourite List')));
        } else {
          widget.product!.isPopular = 1;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(' The Product added to Favourite List')));
        }
        await _dbHelper.updateDateItem(widget.product!);

        setState(() {
          getFavouriteProducts(widget.products!);
        });
        break;
      case DismissDirection.up:
        setState(() {
          if (widget.product!.colors != 0)
            { addProductToCart(widget.product!, context);
            countFav=widget.products!.favouriteList.length;
            getFavouriteProducts(widget.products!);
            }

        });
        break;
      default:
        break;
    }

    getProdProducts(widget.products!);
  }
}
