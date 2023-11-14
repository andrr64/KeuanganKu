// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'dart:math' as Math;

/// Mendapatkan ukuran lebar berdasarkan perbandingan
/// * wxW: ukuran lebar widget pada figma
/// * dW: ukuran lebar device pada figma
/// * max?: ukuran maksimal lebar (default: null)
double widthByRatio(double wxW, double dW, BuildContext context, double? max){
  double result = (wxW/dW) * MediaQuery.sizeOf(context).width;
  if (max != null){
    return result > max? max : result;
  }
  return result;
}

double getDynamicFontSizeByWidthContext(double basicSize, String text, BuildContext context){
    double scaleFactor = 1 - (text.length - 6) * 0.05; // 0.05 adalah faktor pengurangan per karakter
    double scaledSize = basicSize * scaleFactor;
    return Math.min(scaledSize, MediaQuery.sizeOf(context).width); // Pastikan ukuran font tidak melebihi lebar container
}


double getWidthOf(BuildContext context){
  return MediaQuery.sizeOf(context).width;
}

double getHeightOf(BuildContext context){
  return MediaQuery.sizeOf(context).height;
}

double getPerbandingan(int jumlahWidget){
  return 0.92 / jumlahWidget;
}