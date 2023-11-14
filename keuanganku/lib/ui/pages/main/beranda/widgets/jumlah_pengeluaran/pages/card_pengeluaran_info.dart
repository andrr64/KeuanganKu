import 'package:flutter/material.dart';
import 'package:keuanganku/ui/appbar.dart';

class CardTotalPengeluaranInformasi extends StatelessWidget {
  const CardTotalPengeluaranInformasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getOtherPageAppBar("Data Pengeluaran"),
    );
  }
}