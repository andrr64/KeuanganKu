import 'package:flutter/material.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/util/font_style.dart';

void showSnackBar(BuildContext context, {required  Pesan jenisPesan, required String msg}){
  late Color color;
  switch (jenisPesan) {
    case Pesan.Success:
      color = Colors.green;
      break;
    case Pesan.Error:
      color = Colors.red;
      break;
    case Pesan.Warning:
      color = Colors.yellow;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(msg, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium", color: Colors.white),)
    )
  );
}