import 'package:flutter/material.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class KEmpty extends StatelessWidget {
  const KEmpty({super.key, this.actions});
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    // const listVariant = [
    //   "assets/lotties/animation/empty.json",
    //   "assets/lotties/animation/empty1.json",
    //   "assets/lotties/animation/empty2.json",
    //   "assets/lotties/animation/empty3.json",
    // ];

    List<Widget> getAction(){
      return actions != null ? actions! : [];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: makeCenterWithRow(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              makeCenterWithRow(child: const Icon(Icons.close_rounded, size: 50, color: Colors.black26,),),
              Text("Kosong :(", style: kFontStyle(fontSize: 15, color: Colors.black26),),
              for(var widget in getAction()) widget
            ],
          ),
        ),
      ),
    );
  }
}