import 'package:flutter/material.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class Properties {
  final Color backgroundColor = Colors.white;
}

/// Create by andrr64
class KCard extends StatelessWidget {
  KCard({super.key, required this.title, required this.child, this.width, this.height, this.icon, this.button});
  final Widget child;
  final String title;
  final double? width;
  final double? height;
  final Widget? button;
  final Properties properties = Properties();
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.sizeOf(context);
    final double cardWidth = width ?? displaySize.width;

    Widget getTitle(){
      return Text(
        title, 
        style: kFontStyle(fontSize: 20),
      );
    }

    return IntrinsicWidth(
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      icon?? const SizedBox(),
                      const SizedBox(width: 10,),
                      getTitle(),
                    ],
                  ),
                  button?? const SizedBox()
                ],
              ),
              dummyHeight(),
              child
            ],
          ),
        ),
      ),
    );
  }
}