import 'package:abdelrahman/components/image_card.dart';
import 'package:abdelrahman/components/starRatings.dart';
import 'package:abdelrahman/control/Product_service.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/model/Cart.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final Product product;

  Body({Key? key, required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DbHelper _dbHelper = DbHelper();

  bool flag = false;


  void addQty() {
    setState(() {
      if (widget.product.colors! > widget.product.rating!) {
        widget.product.colors = widget.product.rating;
      } else if (widget.product.colors! < widget.product.rating!) {
        setState(() {
          widget.product.colors = widget.product.colors! + 1;
        });
      }
    });
  }

  void subQty() {
    setState(() {
      if (widget.product.colors != 0) {
        widget.product.colors = widget.product.colors! - 1;
      } else if (widget.product.colors! < 1) {
        setState(() {
          widget.product.colors = 0;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 20.0,
        right: 20.0,
        left: 20.0,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              IconButton(
                  onPressed: () {
                    widget.product.rating=3;
                    _dbHelper.updateDateItem(widget.product);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('you  added 3 item to stock ')));

                  },
                  icon:Icon(Icons.add_to_photos_outlined)),

              IconButton(
                  onPressed: () {
    _dbHelper.deleteDateItem(widget.product.id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(' The delete from stock ')));
    Navigator.of(context).pop();
    },
                  icon:Icon(Icons.delete)),

              IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.product.isPopular == 1)
                        widget.product.isPopular = 0;
                      else
                        widget.product.isPopular = 1;
                    });
                    _dbHelper.updateDateItem(widget.product);
                    print(widget.product.isPopular);
                  },
                  icon: widget.product.isPopular == 1
                      ? Icon(
                    Icons.favorite,
                    color: Colors.red[800],
                  )
                      : Icon(Icons.favorite_border)),
            ],),

            Container(
              height: 200,
              child: Hero(
                tag: widget.product.id!,
                child: ImageCard(image: widget.product.image),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              widget.product.title!,
              style: TextStyle(fontSize: 20, color: kBlackColor),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "\$${widget.product.price!.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 20,
                    color: widget.product.priceBefore! > widget.product.price!
                        ? Colors.green
                        : kPrimaryColor),
              ),
            ),
            widget.product.priceBefore! > widget.product.price!
                ? Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "\$${widget.product.priceBefore!.toStringAsFixed(2)}",
                      style: TextStyle(
                          decoration: TextDecoration.combine([
                            TextDecoration.lineThrough,
                            TextDecoration.lineThrough
                          ]),
                          fontSize: 16,
                          color: kGrayColor),
                    ),
                  )
                : SizedBox(),
            Builder(builder: (context) {
              return Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: IconTheme(
                          data: IconThemeData(
                            color: Colors.amberAccent,
                            size: 18,
                          ),
                          child: StarDisplay(value: 4),
                        ),
                      ),
                    ), widget.product.rating! !=0?
                    Container(
                      height: 45.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kWhiteColor,
                      ),
                      child: Row(children: [
                        Container(
                          width: 35.0,
                          child: RawMaterialButton(
                            onPressed: subQty,
                            child: widget.product.colors != 0
                                ? Icon(
                                    Icons.remove,
                                    color: kPrimaryColor,
                                    size: 30.0,
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
                            widget.product.colors.toString(),
                            style: TextStyle(fontSize: 22, color: kBlackColor),
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
                          width: 35.0,
                          child: RawMaterialButton(
                            onPressed: addQty,
                            child:
                                widget.product.colors != widget.product.rating!
                                    ? Icon(
                                        Icons.add,
                                        color: kWhiteColor,
                                        size: 30.0,
                                      )
                                    : Text(
                                        'MAX',
                                        style: TextStyle(color: kWhiteColor),
                                      ),
                          ),
                        ),
                      ]),
                    ):Text('Out of stock'),
                  ],
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                'About this product',
                style: TextStyle(fontSize: 16, color: kBlackColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                widget.product.description!,
                style: TextStyle(fontSize: 16, color: kGrayColor),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
