import 'package:abdelrahman/components/primary_button.dart';
import 'package:abdelrahman/control/Product_service.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Cart.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';
import 'components/body.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(),
      body: Body(product: agrs.product),
      bottomNavigationBar: Container(
        color: kWhiteColor,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
        child: PrimaryButton(
          title: "Add to bag",
          onPressed: () {
            setState(() {
              if (agrs.product.colors != 0)
              { addProductToCart(agrs.product, context);

              }

            });
            getProdProducts(agrs.products!);

           ProductsNotifier().notife();
          },
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final ProductsNotifier? products;

  ProductDetailsArguments(this.products,  this.product);
}
