import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class TombolTambah {
  final VoidCallback ketikaDitekan;
  TombolTambah({required this.ketikaDitekan});

  Widget getWidget(){
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: ApplicationColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        )
      ),
      onPressed: ketikaDitekan,
      child: const Text("Tambah")
    );
  }
}