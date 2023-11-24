import 'package:flutter/material.dart';

class Data {
  final Color backgroundColor = Colors.white;
}

class HalamanWallet extends StatefulWidget {
  HalamanWallet({super.key});
  final Data data = Data();

  @override
  State<HalamanWallet> createState() => _HalamanWalletState();
}

class _HalamanWalletState extends State<HalamanWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.data.backgroundColor,
    );
  }
}
