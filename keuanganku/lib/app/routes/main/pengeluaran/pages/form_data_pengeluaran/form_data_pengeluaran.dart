// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/widgets/date_picker/show_date_picker.dart';
import 'package:keuanganku/app/widgets/heading_text/heading_text.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/widgets/time_picker/show_time_picker.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Data {
  SQLModelWallet? walletTerpilih;  
  SQLModelCategory? kategoriTerplilih;
}

class FormDataPengeluaran extends StatefulWidget {
  FormDataPengeluaran({
    super.key, 
    required this.listWallet, 
    required this.listKategori, 
    required this.callback,
    this.pengeluaran,
    this.withData,
    this.readOnly,
    this.walletAndKategori
  });
  final List<SQLModelWallet> listWallet;
  final List<SQLModelCategory> listKategori;
  final Data data = Data();
  final VoidCallback callback;
  final SQLModelExpense? pengeluaran;
  final bool? withData;
  final bool? readOnly;
  final Map<String,dynamic>? walletAndKategori;

  @override
  State<FormDataPengeluaran> createState() => _FormDataPengeluaranState();
}

class _FormDataPengeluaranState extends State<FormDataPengeluaran> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerWaktu = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerInfoRating = TextEditingController();
  
  DateTime tanggalPengeluaran = DateTime.now();
  TimeOfDay jamPengeluaran = TimeOfDay.now();
  double ratingPengeluaran = 3;

  // Events
  void eventSimpanPengeluaran(BuildContext context, Size size) {
    Future memprosesData() async{
      // Validator
      try {
        double.tryParse(controllerJumlah.text)!;
      } catch (invalidDouble){
        KDialogInfo(
          title: "Invalid", 
          info: "Masukan sebuah angka", 
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
        return;
      }
      double jumlahPengeluaran = double.parse(controllerJumlah.text);
      double jumlahUangPadaWallet = await widget.data.walletTerpilih!.totalUang();
      if (jumlahUangPadaWallet < jumlahPengeluaran){
        KDialogInfo(
          title: "Gagal", 
          info: "Uang anda tidak cukup", 
          jenisPesan: Pesan.Warning
        ).tampilkanDialog(context);
        return;
      }
      // Process
      SQLModelExpense dataBaru = SQLModelExpense(
        id: -1, 
        id_wallet: widget.data.walletTerpilih!.id, 
        id_kategori: widget.data.kategoriTerplilih!.id, 
        judul: controllerJudul.text, 
        deskripsi: controllerDeskripsi.text, 
        nilai: double.tryParse(controllerJumlah.text)!, 
        rating: ratingPengeluaran, 
        waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran),
      );

      if ((await SQLHelperExpense().insert(dataBaru, db: db.database)) != -1) {
        tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
        widget.callback();
        HalamanPengeluaran.state.update();
        HalamanWallet.state.update();
        HalamanBeranda.state.update();
      } else {
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
      }
      Navigator.pop(context);
    }
    memprosesData().then((value) => {});
  }

  // Widgets
  Widget heading(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25,),
          child: HeadingText().h1("+ Pengeluaran Baru"),
        ),
        GestureDetector(
          child: const  Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Icon(Icons.close),
          ),
          onTap: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }
  Widget fieldJudul(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJudul, 
        fieldName: "Judul", 
        icon: Icons.title_sharp,
        prefixIconColor: ApplicationColors.primary  ),
    );
  }
  Widget fieldJumlah(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJumlah, 
        fieldName: "Jumlah", 
        icon: Icons.attach_money,
        keyboardType: TextInputType.number,
        prefixIconColor: ApplicationColors.primary),
    );
  }
  Widget fieldDeskripsi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controllerDeskripsi,
        maxLines: 5, // Sesuaikan dengan jumlah baris yang diinginkan
        decoration: const InputDecoration(
          label: Text("Deskripsi"),
          border: OutlineInputBorder()
        ),
      ),
    );
  }
  Widget fieldTanggal(BuildContext context, Size size){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: KTextField(
              fieldController: controllerTanggal, 
              fieldName: "Tanggal", 
              readOnly: true,
              prefixIconColor: ApplicationColors.primary,
              icon: Icons.calendar_month,
              onTap: () async {
                tanggalPengeluaran = await tampilkanDatePicker(
                  context: context,
                  waktuAwal: DateTime(2000),
                  waktuAkhir: DateTime.now(),
                  waktuInisialisasi: tanggalPengeluaran
                );
                controllerTanggal.text = formatTanggal(tanggalPengeluaran);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget fieldJam(BuildContext context, Size size){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: KTextField(
              fieldController: controllerWaktu, 
              fieldName: "Jam", 
              readOnly: true,
              prefixIconColor: ApplicationColors.primary,
              icon: Icons.alarm,
              onTap: () async {
                jamPengeluaran = await tampilkanTimePicker(context: context, waktu: jamPengeluaran);
                controllerWaktu.text = formatWaktu(jamPengeluaran);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget dropDownMenuWallet(){
    if (widget.withData == true){
      for (var wallet  in widget.listWallet) {
        if (wallet.id == widget.walletAndKategori!['wallet'].id){
          widget.data.walletTerpilih = wallet;
          break;
        }
        widget.data.walletTerpilih = null;
      }
    }

    // Hapus pemilihan default
    widget.data.walletTerpilih ??= widget.listWallet[0];

    // Menggunakan Set untuk menyimpan nilai unik
    Set<SQLModelWallet> uniqueWallets = widget.listWallet.toSet();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KDropdownMenu<SQLModelWallet>(
        items: uniqueWallets.map((e){
          return DropdownMenuItem<SQLModelWallet>(
            value: e,
            child: Row(
              children: [
                Icon(e.tipe == "Wallet"? Icons.wallet : Icons.account_balance),
                const SizedBox(width: 10,),
                Text(e.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),)
              ],
            )
          );
        }).toList(), 
        onChanged: (val){
          widget.data.walletTerpilih = val;
        }, 
        value: widget.data.walletTerpilih!, 
        labelText: "Wallet"
      ).getWidget(),
    );
  }
  Widget dropDownKategori(BuildContext context){
    List<DropdownMenuItem<SQLModelCategory>> items (){
      List<DropdownMenuItem<SQLModelCategory>> listItem = widget.listKategori.map((kategori){
          return DropdownMenuItem<SQLModelCategory>(
            value: kategori,
            child: Text(kategori.judul, style: kFontStyle(fontSize: 16, family: "QuickSand_Medium"),),
          );
        }).toList();
      listItem.add(
        DropdownMenuItem<SQLModelCategory>(
          value: SQLModelCategory(id: 0, judul: "Tambah Kategori"),
          child: Row(
            children: [
              const Icon(Icons.add), 
              const SizedBox(width: 10,), 
              Text("Tambah Kategori", 
              style: kFontStyle(
                fontSize: 16, 
                family: "QuickSand_Medium"),
              )
            ],
          )
        ),
      );
      return listItem;
    }
    if (widget.withData == true){
      for (var ktg in widget.listKategori) {
        if (ktg.id == widget.walletAndKategori!['kategori'].id){
          widget.data.kategoriTerplilih = ktg;
          break;
        }
        widget.data.kategoriTerplilih = null;
      }
    }
    widget.data.kategoriTerplilih ??= widget.listKategori[0];
    
    return IntrinsicWidth(
      child: KDropdownMenu<SQLModelCategory>(
        items: items(), 
        onChanged: (val){
          if (val!.id == 0){
            bool newCategoryCreated = false;
            showDialog(context: context, builder: (dialogContext){
              TextEditingController controllerNamaKategori = TextEditingController();
              return AlertDialog(
                contentPadding: const EdgeInsets.all(25.0), // Sesuaikan dengan kebutuhan Anda
                backgroundColor: Colors.white,
                title: const Text("Kategori Baru"),
                content: IntrinsicHeight(
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KTextField(
                          fieldController: controllerNamaKategori, 
                          fieldName: "Judul", 
                          prefixIconColor: ApplicationColors.primary,
                          icon: Icons.title,
                        ),
                        dummyPadding(height: 15),
                        KButton(
                          onTap: () {
                            if (controllerNamaKategori.text.isEmpty){
                              return;
                            }
                            SQLHelperExpenseCategory().insert(
                              SQLModelCategory(
                                id: -1, 
                                judul: controllerNamaKategori.text
                              ), 
                              db: db.database
                            );
                            newCategoryCreated = true;
                            Navigator.pop(dialogContext);
                          }, 
                          color: Colors.white,
                          bgColor: Colors.green,
                          title: "Simpan", 
                          icon: const Icon(Icons.save, color: Colors.white,)
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).then((value){
              if (newCategoryCreated){
                tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Kategori baru berhasil ditambahkan");
                Navigator.pop(context);
              }
            });
            return;
          }
          widget.data.kategoriTerplilih = val;
        }, 
        value: widget.data.kategoriTerplilih!, 
        labelText: "Kategori",
      ).getWidget(),
    );
  }
  Widget buttonClear(){
    return KButton(
      onTap: (){
        controllerJudul.text = "";
        controllerJumlah.text = "";
        widget.data.walletTerpilih = widget.listWallet[0];
        setState(() {});
      }, 
      color: Colors.white, 
      bgColor: Colors.red, 
      title: "Bersihkan", 
      icon: const Icon(Icons.clear, color: Colors.white));
    }
  Widget buttonSimpan(BuildContext context, Size size){
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KButton(
        onTap: (){
          eventSimpanPengeluaran(context, size);
        },
        title: "Simpan", 
        icon: const Icon(Icons.save, color: Colors.white,),
        color: Colors.white,
        bgColor: Colors.green,
      ),
    );
  }
  Widget ratingBar(){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: KTextField(
              fieldController: controllerInfoRating, 
              fieldName: "Rating", 
              prefixIconColor: ApplicationColors.primary,
              icon: Icons.star,
              readOnly: true,
            ),
          ),
          const SizedBox(width: 10,),
          RatingBar.builder(
            initialRating: ratingPengeluaran,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.only(right: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 32.5,
            onRatingUpdate: (rating) {
              ratingPengeluaran = rating;
              controllerInfoRating.text = SQLModelExpense.infoRating(rating);
            },
          ),
        ],
      ),
    );
  }

  List<Widget>? action (BuildContext context){
    if (widget.withData == true){
      return [
          GestureDetector(
            onTap: (){
              KDialogInfo(
                title: "Anda yakin?", 
                info: "Data tidak bisa dikembalikan dan uang akan dikembalikan ke wallet", 
                jenisPesan: Pesan.Konfirmasi,
                action: [
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () async {
                          int exitCode = await SQLHelperExpense().delete(widget.pengeluaran!.id, db: db.database);
                          if (exitCode != -1){
                            widget.callback();
                            Navigator.pop(context);
                            tampilkanSnackBar(context, jenisPesan: Pesan.Konfirmasi, msg: "data berhasil dihapus");
                          } else {
                            tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "something wrong...");
                          }
                        }, 
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check, color: Colors.white,),
                            Text("Ok"),
                          ],
                        )
                      ),
                      const SizedBox(width: 10,),
                      FilledButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.cancel, color: Colors.white,),
                            Text("Batal"),
                          ],
                        )
                      ),
                    ],
                  )
                ]
              ).tampilkanDialog(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(CupertinoIcons.delete),
            ),
          )
        ];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.withData == true){
      controllerJudul.text = widget.pengeluaran!.judul;
      controllerDeskripsi.text = widget.pengeluaran!.deskripsi;
      controllerTanggal.text = formatTanggal(widget.pengeluaran!.waktu);
      controllerWaktu.text = formatWaktu(TimeOfDay(hour: widget.pengeluaran!.waktu.hour, minute: widget.pengeluaran!.waktu.minute));
      controllerJumlah.text = widget.pengeluaran!.nilai.toString();
      controllerInfoRating.text = SQLModelExpense.infoRating(widget.pengeluaran!.rating);
      ratingPengeluaran = widget.pengeluaran!.rating;
    }
    else {
      controllerTanggal.text = formatTanggal(tanggalPengeluaran);
      controllerWaktu.text = formatWaktu(jamPengeluaran);
      controllerInfoRating.text = SQLModelExpense.infoRating(ratingPengeluaran);
      ratingPengeluaran = 3;
    }

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(
        backgroundColor: Colors.white, 
        title: widget.withData == true? "Detail Pengeluaran" : "Pengeluaran Baru", 
        fontColor: ApplicationColors.primary,
        action: action(context)
      ).getWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            dummyPadding(height: 15),
            fieldJudul(),
            dummyPadding(height: 20),
            fieldJumlah(),
            dummyPadding(height: 20),
            fieldDeskripsi(),
            dummyPadding(height: 20),
            dropDownMenuWallet(),
            dummyPadding(height: 20),
            fieldTanggal(context, size),
            dummyPadding(height: 20),
            Row(
              children: [
                fieldJam(context, size),
                const SizedBox(width: 15,),
                dropDownKategori(context),
              ],
            ),
            dummyPadding(height: 20),
            ratingBar(),
            dummyPadding(height: 20),
            Row(
              children: [
                buttonSimpan(context, size),
                buttonClear(),
              ],
            ),
            dummyPadding(height: 50)
          ]
        ),
      )
      );
  }
}
