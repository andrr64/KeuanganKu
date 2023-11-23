import 'package:flutter/material.dart';
import 'package:keuanganku/application_info.dart';

class Properties {
  Color primaryColor = const Color(0xff3F4245);
}

class AppDrawer extends StatelessWidget {
  /// Drawer aplikasi
  AppDrawer({super.key});
  final Properties property = Properties();
  
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
            child: Padding(
              padding: const EdgeInsets.only(left: besarPaddingKiri, top: besarPadding, bottom: besarPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ApplicationInfo.title, 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: "QuickSand_Bold"),
                    ),
                  Text(
                    ApplicationInfo.buildMode, 
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter"),
                  ),
                  const Text(
                    ApplicationInfo.stringAppVersion, 
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