import 'package:flutter/material.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

Text getJudul(String judul) {
  return Text(
    judul,
    style: const TextStyle(
        fontFamily: "Quicksand_Bold", fontSize: 30, color: Warna.warna_primer),
  );
}

Text _getInfo(String info) {
  return Text(
    info,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontFamily: "Quicksand",
      fontSize: 14,
      color: Warna.warna_primer,
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
        ),
      ),
      Container(
          alignment: Alignment.center, height: 50, child: getJudul(judul)),
      Container(alignment: Alignment.center, width: 300, child: _getInfo(info))
    ],
  );
}

