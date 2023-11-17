import 'package:flutter/material.dart';

class Properties {
  final Color primaryColor = const Color(0xff383651);
}

class Widgets {

}

class HalamanRingkasan extends StatefulWidget {
  HalamanRingkasan({super.key});
  final Widgets widgets = Widgets();
  final Properties properties = Properties();

  @override
  State<HalamanRingkasan> createState() => HalamanRingkasanState();
}

class HalamanRingkasanState extends State<HalamanRingkasan> {

  Widget formatWidget({required Widget child}){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: child,);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],        
          ),
        ),
      ),
    );
  }
}