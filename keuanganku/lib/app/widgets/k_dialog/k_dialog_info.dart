import 'package:flutter/material.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/enum/status.dart';

class KDialogInfo{
  final String title;
  final String info;
  final Pesan jenisPesan;
  BuildContext? dialogContext;

  KDialogInfo({
    required this.title,
    required this.info,
    required this.jenisPesan
  });


  tampilkanDialog(BuildContext context){
    showDialog(context: context, builder: (_){
      dialogContext = _;
      return  AlertDialog(
        title: Text(title),
        content: Text(info),
        actions: [
          KButton(onTap: (){Navigator.pop(_);}, title: "Ok", icon: const SizedBox())
        ],
      );
    });
  }
}