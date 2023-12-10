import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
class DetailTransaksi extends StatelessWidget {
  const DetailTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 200,
          color: ApplicationColors.primary,
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 0.1 / 2,
          left: MediaQuery.of(context).size.width * 0.1 / 2,
          child: Container(
            height: 800,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ), 
        )

      ],
    );
  }
}