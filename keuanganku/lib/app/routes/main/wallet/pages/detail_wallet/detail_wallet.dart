import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/app_bar/app_bar.dart';

class DetailWallet extends StatefulWidget {
  const DetailWallet({super.key});

  @override
  State<DetailWallet> createState() => _DetailWalletState();
}

class _DetailWalletState extends State<DetailWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: 'Detail Wallet',
        fontColor: ApplicationColors.primary
      ).getWidget(),
    );
  }
}
