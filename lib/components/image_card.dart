import 'dart:io';

import 'package:abdelrahman/theme.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, this.image}) : super(key: key);
  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 0),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.file(File(image), fit: BoxFit.fill,
            //   height: _picHeight,
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: Duration(seconds: 5),
            curve: Curves.easeOut,
            child: child,
          );
        }, errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
          return Icon(Icons.image_outlined);
        }),
      ),
    );
  }
}
