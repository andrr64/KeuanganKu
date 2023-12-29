import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class ItemKategori {
  SQLModelCategory data;
  BuildContext context;
  Widget? child;
  bool? isLongPressEvent = false;
  Function() onDeleted;

  ItemKategori({
    required this.context,
    required this.data,
    required this.onDeleted,
    this.child,
    this.isLongPressEvent
  });

  List<KWidget>   menu(){
    Widget buildMenu(Icon icon, String title, String subtitle, Function() onTap){
      return GestureDetector(
        onTap: onTap,
        child: Card(
          child: InkWell( // Gunakan InkWell di sini
            splashColor: Colors.black38,
            onTap: onTap, // Warna splash yang diinginkan
            child: ListTile(
              title: Text(title, style: kFontStyle(fontSize: 13)),
              leading: icon,
              subtitle: Text(subtitle, style: kFontStyle(fontSize: 13, family: "QuickSand_Medium")),
            ), // Anda dapat tetap mempertahankan onTap di sini jika diperlukan
          ),
        ),
      );
    }
    
    Widget menuUbah(){
      return buildMenu(const Icon(Icons.edit), "Ubah", "Ubah nama kategori dll.", () => null);
    }
    Widget menuHapus(){
      void onTap(){
        void onOk(){
          Future getData() async {
            return await SQLHelperIncomeCategory().readIsThereAnyReferencedData(data.id, db.database);
          }
          getData().then((thereIsDataReferenced){
            if (thereIsDataReferenced){
              KDialogInfo(
                title: "Error", 
                info: "Terdapat data pengeluaran yang menggunakan kategori ini", 
                jenisPesan: Pesan.Warning
              ).tampilkanDialog(context);
            } else {
              Navigator.pop(context);
              onDeleted();
            }
          });
        }
        KDialogInfo(
          title: "Konfirmasi", 
          info: "Kamu yakin ingin menghapus kategori ini?", 
          jenisPesan: Pesan.Konfirmasi,
          onOk: onOk,
          okTitle: "Yap tetep hapus",
          cancelTitle: "Gak jadi deh"
        ).tampilkanDialog(context);
      } 
      return buildMenu(const Icon(Icons.delete), "Hapus", "Hapus kategori ini", onTap);     
    }

    return [
      menuUbah(),
      menuHapus(),
    ];
  }

  KEventHandler onLongPress(){
    if (!isLongPressEvent!) return;
    showDialog(
    context: context, 
    builder: (_){
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Aksi", style: kFontStyle(fontSize: 20),),
                      GestureDetector(
                        child: const Icon(Icons.close, color: KColors.fontPrimaryBlack,),
                        onTap: (){
                          Navigator.pop(_);
                        },
                      ),
                    ],
                  ),
                  dummyHeight(),
                  for(var widget in menu()) widget,
                ],
              ),
            ),
          ),
        ),
      );
    }
  );
  }

  DropdownMenuItem<SQLModelCategory> getWidget(){
    return DropdownMenuItem<SQLModelCategory>(
      value: data,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: child ?? Text(data.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
      )
    );
  }
}