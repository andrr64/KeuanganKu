// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';

/*
KCardStateless
Version: 1.0.0
Costum Widget for 'KeuanganKu'
Designed by Derza Andreas 
*/

class KCardStateless extends StatelessWidget{
  const KCardStateless({
    super.key, 
    required this.cardTitle,
    required this.size, 
    required this.child,
    required this.backgroundColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.centerTitle = false,
    this.titleFontsize = 15,
    this.titleFontColor = Colors.white,
    this.padding = const EdgeInsets.all(15),
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  final bool centerTitle;
  final String cardTitle;
  final double titleFontsize;
  final Color titleFontColor;
  final EdgeInsets padding;
  final Widget child;
  final Size size;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final String _titleFontfamily = "QuickSand_SemiBold"; // Change default 'title' font family here
  
  _parameterValidation(BuildContext context){
    /// Call this function before build the widget
    /// This function will make sure everything is okay
  }


  @override
  Widget build(BuildContext context) {
    _parameterValidation(context);
   
    getBoxDecoration(){
      return BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius
      );
    }

    getTitleStyle(){
      return TextStyle(
        fontFamily: _titleFontfamily,
        fontSize: titleFontsize,
        color: titleFontColor
      );
    }

    return Container(
      width: size.width,
      decoration: getBoxDecoration(),
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(cardTitle, style: getTitleStyle(),),
          child
        ],
      ),
    );
  } 
}