import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_leadingbutton_back_ios/k_leadingbutton_back_iosStyle.dart';
import 'package:keuanganku/app_info.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
const String tentangAplikasi = """
KeuanganKu hadir sebagai platform inovatif yang dirancang khusus untuk memberikan dukungan dalam mengelola keuangan Anda secara lebih efisien. Dengan fitur-fitur andalan yang tersedia, tujuan platform ini adalah untuk memudahkan Anda dalam perencanaan, pemantauan, dan optimalisasi segala aspek keuangan Anda.

Project ini mengacu pada modul praktik dari mata kuliah Mobile Programming Universitas Bina Sarana Informatika (UBSI) yang diampu oleh Bpk. Yuris Alkhalifi, M.Kom., CPDSA selaku Dosen.
""";
class TentangAplikasi extends StatefulWidget {
  const TentangAplikasi({super.key});

  @override
  State<TentangAplikasi> createState() => _TentangAplikasiState();
}

class _TentangAplikasiState extends State<TentangAplikasi> {
  KApplicationBar   appBar      (BuildContext context){
    return KAppBar(
        title: "",
        backgroundColor: Colors.white,
        fontColor: ApplicationColors.primary,
        leading: KLeadingBackIOS(
          onTap: (){
            Navigator.pop(context);
          },
          color: ApplicationColors.primary,
        ),
    ).getWidget();
  }

  Widget tentang() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(),
        Text("Tentang", style: kFontStyle(fontSize: 18, family: "QuickSand_Medium"),),
        Text("KeuanganKu ${ApplicationInfo.stringAppVersion}", style: kFontStyle(fontSize: 26),),
        dummyHeight(height: 10),
        Text(tentangAplikasi, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
      ],
    );
  }
  Widget pengembang() {
    Widget buildProfilePengembang({required String nama, required String tugas}){
      return Row(
        children: [
          const Icon(Icons.person_2_rounded, color: ApplicationColors.primary, size: 40,),
          dummyWidth(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nama, style: kFontStyle(fontSize: 14),),
              Text(tugas, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),)
            ],
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(),
        Text("Pengembang", style: kFontStyle(fontSize: 18,),),
        dummyHeight(height: 12.5),
        buildProfilePengembang(nama: "Derza Andreas", tugas: "UI/UX | Front-End | Back-End"),
        dummyHeight(height: 12.5),
        buildProfilePengembang(nama: "Rifqi Abdillah Rosyad", tugas: "Front-End | Dokumentasi"),
        dummyHeight(height: 12.5),
        buildProfilePengembang(nama: "Muhammad Dhafa Mahardika", tugas: "Back-End | Dokumentasi"),
        dummyHeight(height: 12.5),
        buildProfilePengembang(nama: "Muhammad Fajar Raihan", tugas: "Desainer Basis Data | Dokumentasi"),
        dummyHeight(height: 12.5),
        buildProfilePengembang(nama: "Syafiq Najwan", tugas: "Desainer Basis Data | Dokumentasi"),
        dummyHeight(height: 25),
      ],
    );
  }
  Widget lisensi() {
    const lisensi = """Aplikasi ini menggunakan lisensi GNU General Public License (GPL), yang memberikan kebebasan kepada pengguna untuk menggunakan, memodifikasi, dan mendistribusikan perangkat lunak tanpa pembatasan. Pengguna dapat menjalankan aplikasi ini tanpa biaya dan memiliki hak untuk mengakses serta memodifikasi kode sumber.""";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(),
        Text("Lisensi", style: kFontStyle(fontSize: 18,),),
        dummyHeight(height: 12.5),
        Text(lisensi, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
        dummyHeight(height: 25),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider();
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tentang(),
              divider,
              pengembang(),
              divider,
              lisensi(),
              divider,
              makeCenterWithRow(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("Akhir Halaman", style: kFontStyle(fontSize: 12, color: Colors.black45),),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
