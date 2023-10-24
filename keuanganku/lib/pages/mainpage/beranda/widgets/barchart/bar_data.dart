import 'package:keuanganku/pages/mainpage/beranda/widgets/barchart/individual_bar.dart';

class BarDataMingguan {
  final double senin;
  final double selasa;
  final double rabu;
  final double kamis;
  final double jumat;
  final double sabtu;
  final double minggu;

  BarDataMingguan({
    required this.senin,
    required this.selasa,
    required this.rabu,
    required this.kamis,
    required this.jumat,
    required this.sabtu,
    required this.minggu,
  });

  List<IndividualBar> barData = [];
  void inisialisasiBarData() {
    barData = [
      IndividualBar(x: 0, y: senin),
      IndividualBar(x: 1, y: selasa),
      IndividualBar(x: 2, y: rabu),
      IndividualBar(x: 3, y: kamis),
      IndividualBar(x: 4, y: jumat),
      IndividualBar(x: 5, y: sabtu),
      IndividualBar(x: 6, y: minggu),
    ];
  }
}
