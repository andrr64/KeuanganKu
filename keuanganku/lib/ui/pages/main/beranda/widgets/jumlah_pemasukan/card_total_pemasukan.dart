import 'package:flutter/material.dart';
import 'package:keuanganku/ui/kwidgets/kcard_stateless.dart';
import 'package:keuanganku/ui/kwidgets/kwidgets_kcard_stateless.dart';
import 'package:keuanganku/ui/util/size_ratio.dart';

class CardTotalPemasukan extends KWidgetsStatelessCard {
  @override
  void init({parameters}){
      widget = 
        KCardStateless(
          cardTitle: "Pemasukan", 
          size: Size(getWidthOf(parameters) * 0.46, 0), 
          backgroundColor: const Color(0xff464D77), 
          child: getChild()
        );
  }

  @override
  getWidget({parameters}){
    init(parameters: parameters);
    return widget;
  }
  
  @override
  getChild() {
    var dummyTotalpemasukan = "IDR 1,480,000";    
    return Column(
      children: [
        Text(dummyTotalpemasukan, style: const TextStyle(fontFamily: "OpenSans_Bold", fontSize: 16, color: Colors.white),)
      ],
    );
  }
}