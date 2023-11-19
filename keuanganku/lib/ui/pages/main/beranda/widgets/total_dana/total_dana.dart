import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/util.dart';
import 'package:keuanganku/ui/warna_aplikasi.dart';

class TotalDana extends StatefulWidget {
  const TotalDana({super.key, required this.onChange, required this.X });
  final void Function(int) onChange;
  final String X;
  @override
  State<TotalDana> createState() => _TotalDanaState();
}

class _TotalDanaState extends State<TotalDana> {
  @override
  Widget build(BuildContext context) {
    return wrapWithPadding(
      context,
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Dana",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "QuickSand_Medium",
                  color: Warna.getColorByPercentage(percentage: 75)),
            ),
            Text(
              widget.X,
              style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "QuickSand_Bold",
                  color: Warna.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
