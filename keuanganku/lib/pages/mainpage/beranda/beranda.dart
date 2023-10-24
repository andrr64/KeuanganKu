import 'package:flutter/material.dart';
import 'package:keuanganku/pages/mainpage/beranda/warna.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  List<bool> buttonBoolean = [true, false, false];

  void _onButtonChange(int index) {
    setState(() {
      buttonBoolean = [false, false, false];
      buttonBoolean[index] = true;
    });
  }

  late String _userName;
  late String _ucapanWelcome;

  @override
  void initState() {
    super.initState();
    _userName = "Andreas";
    _ucapanWelcome = "Selamat siang,";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _ucapanWelcome,
                    style: const TextStyle(
                        fontSize: 24,
                        fontFamily: "Inter",
                        color: Warna.warna_primer),
                  ),
                  Text(
                    _userName,
                    style: const TextStyle(
                        fontSize: 36,
                        fontFamily: "Inter_Bold",
                        color: Warna.warna_primer),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () => _onButtonChange(0),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: buttonBoolean[0]
                            ? Warna.warna_primer
                            : Local_Warna.warnaButtonUnselected,
                      ),
                      child: Text(
                        "Hari ini",
                        style: TextStyle(
                            color: buttonBoolean[0]
                                ? Colors.white
                                : Local_Warna.warnaTextButtonUnselected),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () => _onButtonChange(1),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: buttonBoolean[1]
                            ? Warna.warna_primer
                            : Local_Warna.warnaButtonUnselected,
                      ),
                      child: Text(
                        "Minggu ini",
                        style: TextStyle(
                            color: buttonBoolean[1]
                                ? Colors.white
                                : Local_Warna.warnaTextButtonUnselected),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () => _onButtonChange(2),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: buttonBoolean[2]
                            ? Warna.warna_primer
                            : Local_Warna.warnaButtonUnselected,
                      ),
                      child: Text(
                        "Bulan ini",
                        style: TextStyle(
                            color: buttonBoolean[2]
                                ? Colors.white
                                : Local_Warna.warnaTextButtonUnselected),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 175,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 190,
                      decoration: const BoxDecoration(
                          color: Warna.warna_primer,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
