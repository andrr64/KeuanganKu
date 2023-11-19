import 'package:flutter/material.dart';

dynamic wrapWithPadding(BuildContext context, Widget child) {
  var size = MediaQuery.sizeOf(context);
  double vPadding = 7.5;
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: (size.width * 0.1) / 2,
      vertical: vPadding,),
    child: child,
  );
}