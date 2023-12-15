import 'package:flutter/cupertino.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class KEmpty extends StatelessWidget {
  const KEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return makeCenterWithRow(
      child: Text(
        "Nothing :(", 
        style: kFontStyle(fontSize: 15, color: ApplicationColors.primary),
      )
    );
  }
}