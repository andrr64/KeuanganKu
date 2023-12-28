import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class KButton extends StatelessWidget {
  const KButton({super.key, required this.onTap, required this.title, this.icon, this.color, this.bgColor});
  final void Function() onTap;
  final Widget? icon;
  final String title;
  final Color? color;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bgColor?? KColors.buttonBgColor, 
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              children: [
                icon == null? const SizedBox() : Padding(
                  padding: const EdgeInsets.only(right: 7.5),
                  child: icon,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "QuickSand_Medium",
                    fontSize: 14,
                    color: color ?? KColors.fontPrimaryBlack
                  ), 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}