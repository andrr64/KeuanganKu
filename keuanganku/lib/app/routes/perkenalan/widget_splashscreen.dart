import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

Text getJudul(String judul) {
  return Text(
    judul,
    style: const TextStyle(
        fontFamily: "Quicksand_Bold", fontSize: 30, color: KColors.fontPrimaryBlack),
  );
}

Text _getInfo(String info) {
  return Text(
    info,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontFamily: "Quicksand",
      fontSize: 14,
      color: KColors.fontPrimaryBlack,
    ),
  );
}

Column getSplashInfo({required judul, required info, required pathImage}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 450,
        alignment: Alignment.center,
        child: Image.asset(
        pathImage,
        height: 275,
        frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: child,
            );
          }
        }
        ),
      ),
      Container(alignment: Alignment.center, height: 50, child: getJudul(judul)),
      Container(alignment: Alignment.center, width: 300, child: _getInfo(info))
    ],
  );
}

