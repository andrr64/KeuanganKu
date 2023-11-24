// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/get_currency.dart';

class Data {
  double get API_Database_GET_totalDana {
    return 1500000;
  }
}

class TotalDana extends StatefulWidget {
  const TotalDana({super.key});

  static StateBridge state = StateBridge();
  static Data data = Data();

  @override
  State<TotalDana> createState() => _TotalDanaState();
}

class _TotalDanaState extends State<TotalDana> {
  @override
  Widget build(BuildContext context) {
    TotalDana.state.init(() {
      setState(() {
        
      });
    });
    
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
                  color: ApplicationColors.primaryColorWidthPercentage(percentage: 75)),
            ),
            Text(
              formatCurrency(TotalDana.data.API_Database_GET_totalDana),
              style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "QuickSand_Bold",
                  color: ApplicationColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
