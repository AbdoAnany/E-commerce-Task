// import 'package:abdelrahman/components/image_card.dart';
// import 'package:abdelrahman/control/Product_service.dart';
// import 'package:abdelrahman/model/Cart.dart';
// import 'package:abdelrahman/screen/details/details_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../../../size_config.dart';
// import '../../../theme.dart';
//
// class CartCard extends StatefulWidget {
//   const CartCard({
//     Key? key,
//     this.cart,
//   }) : super(key: key);
//
//   final Cart? cart;
//
//   @override
//   _CartCardState createState() => _CartCardState();
// }
//
// class _CartCardState extends State<CartCard> {
//   void addQty() {
//     setState(() {
//       if (widget.cart!.product!.colors! > widget.cart!.product!.rating!) {
//         setState(() {
//           widget.cart!.product!.colors = widget.cart!.product!.rating!;
//           billTotal();
//         });
//       } else if (widget.cart!.product!.colors! < widget.cart!.product!.rating!) {
//         setState(() {
//           widget.cart!.product!.colors = widget.cart!.product!.colors! + 1;
//           billTotal();
//         });
//       }
//     });
//   }
//
//   void subQty() {
//     setState(() {
//       if (widget.cart!.product!.colors != 0) {
//         setState(() {
//           widget.cart!.product!.colors = widget.cart!.product!.colors! - 1;
//           billTotal();
//
//         });
//
//       } else if (widget.cart!.product!.colors! < 1) {
//         setState(() {
//           widget.cart!.product!.colors = 0;
//           billTotal();
//
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, DetailsScreen.routeName,
//             arguments: ProductDetailsArguments(pro, widget.cart!.product!));
//       },
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: AspectRatio(
//               aspectRatio: 0.88,
//               child: Container(
//                   //    padding: EdgeInsets.all(getProportionateScreenWidth(5)),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: ImageCard(
//                     image: widget.cart!.product!.image!,
//                   )),
//             ),
//           ),
//           SizedBox(width: 20),
//           Flexible(
//               flex: 6,
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.cart!.product!.title!,
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//                 maxLines: 2,
//                 softWrap: true,
//                 textAlign: TextAlign.justify,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               SizedBox(height: 10),
//               Text.rich(
//                 TextSpan(
//                   text: "\$${widget.cart!.product!.price!.toStringAsFixed(2)} ",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600, color: kPrimaryColor),
//                   children: [
//                     TextSpan(
//
//                         text: " x${widget.cart!.product!.colors!}",
//                         style: Theme.of(context).textTheme.bodyText1),
//                   ],
//                 ),
//               )
//             ],
//           )),Spacer(),
//           Expanded(
//             flex: 1,
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: kWhiteColor,
//               ),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: getScreenHeight(30),
//                       width: getScreenWidth(30),
//                       child: RawMaterialButton(
//                         onPressed: subQty,
//                         child: widget.cart!.product!.colors != 0
//                             ? Icon(
//                           Icons.remove,
//                           color: kPrimaryColor,
//                           size: 25.0,
//                         )
//                             : SizedBox(),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(
//                         right: 5.0,
//                         left: 5.0,
//                       ),
//                       child: Text(
//                         widget.cart!.product!.colors.toString(),
//                         style:
//                         TextStyle(fontSize: 15, color: kBlackColor),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 2.0,
//                     ),
//                     Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: kPrimaryColor,
//                         ),
//                         height: getScreenHeight(30),
//                         width: getScreenWidth(30),
//                         child: RawMaterialButton(
//                           onPressed: addQty,
//                           child: widget.cart!.product!.colors !=
//                               widget.cart!.product!.rating!
//                               ? Icon(
//                             Icons.add,
//                             color: kWhiteColor,
//                             size: 25.0,
//                           )
//                               : Text(
//                             'MAX',
//                             style: TextStyle(fontSize: 12, color: kWhiteColor),
//                           ),
//                         )),
//                   ]),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
