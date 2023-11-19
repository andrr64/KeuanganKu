import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/main_info_apk.dart';

class ObjectProperty {
  Color primaryColor = const Color(0xff3F4245);
}

class ApplicationDrawer extends StatelessWidget {
  /// Drawer aplikasi
  ApplicationDrawer({super.key});
  final ObjectProperty property = ObjectProperty();
  
  @override
  Widget build(BuildContext context) {
    
    const double besarPadding = 40;
    const double besarPaddingKiri = 10;

    return Drawer(
      child: Column(
        children: [
          Container(
            color: property.primaryColor,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.only(left: besarPaddingKiri, top: besarPadding, bottom: besarPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KeuanganKu", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: "QuickSand_Bold"),
                    ),
                  
                  Text(
                    stringAppVersion, 
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter"),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}