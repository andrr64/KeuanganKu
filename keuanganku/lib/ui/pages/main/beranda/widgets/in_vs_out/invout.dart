import 'package:flutter/material.dart';
import 'package:keuanganku/ui/kwidgets/kcard_stateless.dart';
import 'package:keuanganku/ui/kwidgets/kwidgets_kcard_stateless.dart';
import 'package:keuanganku/ui/util/size_ratio.dart';

class ObjectProperty {

}

class Data{

}

class CardInVsOut extends KWidgetsStatelessCard{

  @override
  getWidget({parameters}) {
    init(parameters: parameters);
    return widget;
  }

  @override
  getChild() {
    return const Column(
      children: [
        SizedBox(height: 200,)
      ],
    );
  }
  
  @override
  init({parameters}) {
    widget = KCardStateless(
      cardTitle: "In vs Out",
      crossAxisAlignment: CrossAxisAlignment.center,
      titleFontsize: 20, 
      size: Size(getWidthOf(parameters) * getPerbandingan(1), 0), 
      child: getChild(), 
      backgroundColor: const Color(0xff413C58));
  }
}