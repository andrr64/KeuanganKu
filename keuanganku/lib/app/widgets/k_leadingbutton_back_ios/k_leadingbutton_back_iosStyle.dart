import 'package:flutter/material.dart';
class KLeadingBackIOS extends StatelessWidget {
  const KLeadingBackIOS({super.key, required this.color, required this.onTap});
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.arrow_back_ios,
        color: color,
      ),
    );
  }
}
