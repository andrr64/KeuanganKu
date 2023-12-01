import 'package:keuanganku/API/database/helper/data_pemasukan.dart';
import 'package:keuanganku/API/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';

Future readDataPengeluaranAtauPemasukan(JenisTransaksi jenisTransaksi, WaktuTransaksi waktuTransaksi) async{
  switch(jenisTransaksi){
    case JenisTransaksi.PEMASUKAN:
      return SQLDataPemasukan().readSpecific(waktuTransaksi, db.database);
    case JenisTransaksi.PENGELUARAN:
      return SQLDataPengeluaran().readAll(db.database);
    default:
      return Future(() => []);
  }
}