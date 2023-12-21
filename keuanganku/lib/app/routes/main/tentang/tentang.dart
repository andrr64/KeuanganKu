import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/widgets/k_leadingbutton_back_ios/k_leadingbutton_back_iosStyle.dart';
import 'package:keuanganku/k_typedef.dart';

class TentangAplikasi extends StatefulWidget {
  const TentangAplikasi({super.key});

  @override
  State<TentangAplikasi> createState() => _TentangAplikasiState();
}

class _TentangAplikasiState extends State<TentangAplikasi> {

  KApplicationBar   appBar      (BuildContext context){
    return KAppBar(
        title: "Tentang aplikasi",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
    );
  }
}
