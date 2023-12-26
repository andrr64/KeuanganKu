import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/widgets/k_leadingbutton_back_ios/k_leadingbutton_back_iosStyle.dart';
import 'package:keuanganku/app_info.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
const String tentangAplikasi = """
KeuanganKu hadir sebagai platform inovatif yang dirancang khusus untuk memberikan dukungan dalam mengelola keuangan Anda secara lebih efisien. Dengan fitur-fitur andalan yang tersedia, tujuan platform ini adalah untuk memudahkan Anda dalam perencanaan, pemantauan, dan optimalisasi segala aspek keuangan Anda.

Project ini mengacu pada modul praktik dari mata kuliah Mobile Programming Universitas Bina Sarana Informatika (UBSI) yang diampu oleh Bpk. Yuris Alkhalifi, M.Kom., CPDSA selaku Dosen.
""";
class TentangAplikasi extends StatefulWidget {
  const TentangAplikasi({super.key});

  @override
  State<TentangAplikasi> createState() => _TentangAplikasiState();
}

class _TentangAplikasiState extends State<TentangAplikasi> {

  KApplicationBar   appBar      (BuildContext context){
    return KAppBar(
        title: "",
        backgroundColor: Colors.transparent,
        fontColor: ApplicationColors.primary,
        leading: KLeadingBackIOS(
          onTap: (){
            Navigator.pop(context);
          },
          color: ApplicationColors.primary,
        ),
    ).getWidget();
  }

  Widget tentang(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(),
        Text("Tentang", style: kFontStyle(fontSize: 18, family: "QuickSand_Medium"),),
        Text("KeuanganKu ${ApplicationInfo.stringAppVersion}", style: kFontStyle(fontSize: 26),),
        dummyHeight(height: 10),
        Text(tentangAplikasi, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
      ],
    );
  }
  Widget pengembang(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(),
        Text("Pengembang", style: kFontStyle(fontSize: 25, family: "QuickSand_Medium"),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tentang(),
          ],
        ),
      ),
    );
  }
}
