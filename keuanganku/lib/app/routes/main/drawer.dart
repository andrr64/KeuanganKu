import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/tentang/tentang.dart';
import 'package:keuanganku/app_info.dart';

class AppDrawer extends StatelessWidget {
  /// Drawer aplikasi
  const AppDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    const double besarPadding = 40;
    const double besarPaddingKiri = 10;
    const Divider divider = Divider(
      height: 0,
    );
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          ListTile(
            leading: const Icon(Icons.info), // Ikon di sebelah kiri
            title: const Text('Tentang'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => const TentangAplikasi()));
            },
          ),
          divider,
          const ListTile(
            leading: Icon(Icons.system_security_update), // Ikon di sebelah kiri
            title: Text('Pembaharuan'),
          ),
          divider,
          const ListTile(
              leading: Icon(Icons.favorite), // Ikon di sebelah kiri
              title: Text('Donasi'),
          ),
          divider,
        ],
      ),
    );
  }
}