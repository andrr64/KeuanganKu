import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app_info.dart';

class AppDrawer extends StatelessWidget {
  /// Drawer aplikasi
  const AppDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    const double besarPadding = 40;
    const double besarPaddingKiri = 10;

    return Drawer(
      child: Column(
        children: [
          Container(
            color: ApplicationColors.primary,
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