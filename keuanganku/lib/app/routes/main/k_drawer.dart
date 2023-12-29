import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/tentang/tentang.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app_info.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:url_launcher/url_launcher.dart';

class KeuanganKuDrawer extends StatefulWidget {
  /// Drawer aplikasi
  const KeuanganKuDrawer({super.key});

  @override
  State<KeuanganKuDrawer> createState() => _KeuanganKuDrawerState();
}

class _KeuanganKuDrawerState extends State<KeuanganKuDrawer> {
  Widget donasi(BuildContext context){
    return 
    GestureDetector(
      onTap: (){
        KDialogInfo(
          title: "Donasi", 
          info: "Anda akan menuju ke halaman donasi", 
          jenisPesan: Pesan.Konfirmasi,
          okTitle: "Oke, meluncur",
          cancelTitle: "Ga ah males",
          onOk: (){
            setState(() {
              launchUrl(
                Uri.parse("https://saweria.co/lawx64rence"),
                mode: LaunchMode.externalApplication
              );
            });
          }
        ).tampilkanDialog(context);
      },
      child: const ListTile(
        leading: Icon(Icons.favorite), // Ikon di sebelah kiri
        title: Text('Donasi'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {   
    const Divider divider = Divider(
      height: 0,
    );
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: KColors.backgroundPrimary,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dummyHeight(height: 20),
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
          donasi(context),          
          divider,
        ],
      ),
    );
  }
}