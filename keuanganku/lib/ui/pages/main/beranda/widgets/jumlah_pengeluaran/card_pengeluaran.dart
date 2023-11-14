import 'package:flutter/material.dart';
import 'package:keuanganku/ui/kwidgets/kcard_stateless.dart';
import 'package:keuanganku/ui/util/size_ratio.dart';

class CardTotalPengeluaran {
  KCardStateless? _widget;

  Widget _getChild (){
    var dummyTotalPengeluaran = "IDR 1,480,000";    
    return Column(
      children: [
        Text(dummyTotalPengeluaran, style: const TextStyle(fontFamily: "OpenSans_Bold", fontSize: 16, color: Colors.white),)
      ],
    );
  }

  void _init(BuildContext context){
      _widget = KCardStateless(
      cardTitle: "Pengeluaran", 
      size: Size(getWidthOf(context) * 0.46, 0), 
      backgroundColor: const Color(0xff9A3F51), 
      child: _getChild());
  }

  void reInit(BuildContext context){
    _init(context);
  }

  KCardStateless getWidget(BuildContext context){
    reInit(context);
    return _widget!;
  }
}