// ignore_for_file: file_names

import 'package:flutter/material.dart';

class KLeadingBackIOS extends StatelessWidget {
  const KLeadingBackIOS({super.key, required this.color, required this.onTap});
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: color,
        ),
    );
  }
}
