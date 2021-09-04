import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T? item;
  final Widget? child;
  final DismissDirectionCallback? onDismissed;
  final Function? confirmDismiss;
  const DismissibleWidget({
    this.item,
    this.child,
    this.onDismissed,
    Key? key,
    this.confirmDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: UniqueKey(),
        confirmDismiss: (direction) {

          return Future.value(true);
        },
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child!,
        direction: DismissDirection.endToStart,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: kPrimaryColor,
        child: Icon(Icons.archive_sharp, color: Colors.white, size: 32),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.favorite, color: Colors.white, size: 32),
      );
}
