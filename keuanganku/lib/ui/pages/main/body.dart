import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBody {
  const AppBody({required this.onPageChanged, required this.pageController, required this.body});
  final PageController pageController;
  final void Function(int) onPageChanged;
  final List<Widget> body;
  
  Widget getWidget(){
    return PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      children: body,
    );
  }
}
