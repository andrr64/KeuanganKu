import 'package:flutter/material.dart';

dynamic wrapWithPadding(BuildContext context, Widget child) {
  double vPadding = 5;
  return Padding(
    padding: EdgeInsets.only(
      bottom: vPadding,
      top: vPadding,
      left: 15
    ),
    child: child,
  );
}