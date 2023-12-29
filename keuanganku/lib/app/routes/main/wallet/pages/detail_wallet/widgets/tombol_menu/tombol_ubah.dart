import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/error.dart';
import 'package:keuanganku/util/font_style.dart';

class TombolMenu {
  TombolMenu({
    required this.context,
    required this.wallet,
    required this.onWalletDeleted,
    required this.onNameChanged,
    this.onWalletDeleteProcessError,
  });

  final Function() onNameChanged;
  final Function() onWalletDeleted;
  final Function()? onWalletDeleteProcessError;
  final BuildContext context;
  final SQLModelWallet wallet;

  static Widget   _buildMenu  ({
    required BuildContext context,
    required Function() onTapped,
    required String title,
    required String subtitle,
    Widget? leading,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: InkWell(
        splashColor: Colors.black45, // Tambahkan warna splash disini
        child: ListTile(
          title: Text(
            title,
          ),
          leading: leading,
          trailing: const Icon(Icons.arrow_forward_ios),
          subtitle: Text(
            subtitle,
            style: kFontStyle(fontSize: 12, family: "QuickSand_Medium"),
          ),
        ),
      ),
    );
  }

  KWidget   judul             (BuildContext bottomSheetContext){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Menu", style: kFontStyle(fontSize: 20),),
        GestureDetector(
          onTap: (){
            Navigator.pop(bottomSheetContext);
          },
          child: const Icon(Icons.close, color: KColors.backgroundPrimary,),
        )
      ],
    );
  }
  KWidget   menuUbahNama      (BuildContext bottomSheetContext){
    KBussinesProcess  prosesPengubahanNamaWallet(){
      TextEditingController controllerNama = TextEditingController();
      const int maxLength = 20;
      Future  validatorNamaBaru() async{
        if (controllerNama.text.isEmpty){
          return ValidatorError.InvalidInput;
        }
        wallet.judul = controllerNama.text;
        if (await SQLHelperWallet().update(wallet, db.database) != -1){
          return Condition.OK;
        }
        return Condition.ERROR;
      }
      KEventHandler handlerValidatorNamaBaru(dynamic validatorReturn, BuildContext formDialogContext){
        if (validatorReturn == Condition.OK){
          onNameChanged();
          Navigator.pop(formDialogContext);
        } else if (validatorReturn == ValidatorError.InvalidInput){
          KDialogInfo(
            title: "Error", 
            info: "Masukan nama wallet...", 
            jenisPesan: Pesan.Error
          ).tampilkanDialog(formDialogContext);
        } else if (validatorReturn == Condition.ERROR){
          KDialogInfo(
            title: "Error", 
            info: "Terdapat kesalahan (unexpected)", 
            jenisPesan: Pesan.Error
          ).tampilkanDialog(formDialogContext);
        }
      }

      showDialog(
        context: bottomSheetContext, 
        builder: (alertDialogContext){
          return AlertDialog(
            backgroundColor: Colors.white,
            content: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(alertDialogContext);
                          },
                          child: const Icon(Icons.close, color: KColors.backgroundPrimary,),
                        )
                      ],
                    ),
                    dummyHeight(),
                    Text("Masukan nama wallet yang baru maksimal $maxLength karakter", style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
                    dummyHeight(),
                    KTextField(
                      fieldController: controllerNama, 
                      fieldName: "Nama Baru", 
                      prefixIconColor: Colors.white,
                      maxLength: maxLength,
                    ),
                    KButton(
                      onTap: (){
                        validatorNamaBaru().then((value){
                          handlerValidatorNamaBaru(value, alertDialogContext);
                        });
                      }, 
                      title: "Simpan", 
                      color: Colors.white, 
                      bgColor: KColors.backgroundPrimary,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      );
    }
    return _buildMenu(
      context: bottomSheetContext, 
      onTapped: prosesPengubahanNamaWallet, 
      title: "Nama",
      subtitle: "Salah masukin nama wallet? kamu bisa ubah kok :D",
      leading: const Icon(Icons.title)
    );
  }
  KWidget   menuHapusData     (BuildContext bottomSheetContext){
    KBussinesProcess prosesPenghapusanWallet(){
      SQLHelperWallet().delete(wallet, db.database).then((value){
        if (value == 0){
          tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Wallet berhasil dihapus");
          onWalletDeleted();
        } else {
          KDialogInfo(
            title: "Kesalahan", 
            info: "Terdapat kesalahan saat aplikasi mencoba menghapus data wallet ($value)", 
            jenisPesan: Pesan.Error
          ).tampilkanDialog(context);
          if (onWalletDeleteProcessError != null){
            onWalletDeleteProcessError!();
          }
        }
      });
    }  
    return _buildMenu(
      context: bottomSheetContext, 
      onTapped: (){
        KDialogInfo(
          title: "Anda yakin?", 
          info: "Semua data yang ada di wallet (pemasukan dan pengeluaran) akan dihapus tidak bisa dikembalikan lagi!", 
          jenisPesan: Pesan.Konfirmasi,
          onOk: prosesPenghapusanWallet,
          okTitle: "OK HAPUS AJA",
          cancelTitle: "Gajadi dihapus"
        ).tampilkanDialog(context);
      }, 
      title: "Hapus Wallet", 
      subtitle: "Hapus wallet ini t-t-tapi datanya bakal hilang semua :(",
      leading: const Icon(CupertinoIcons.delete)
    );
  }
  KWidget   menuUbahKategori  (BuildContext bottomSheetContext){
    KBussinesProcess  prosesPengubahanKategoriWallet(){
      showDialog(
        context: bottomSheetContext, 
        builder: (alertDialogContext){
          return AlertDialog(
            backgroundColor: Colors.white,
            content: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(alertDialogContext);
                          },
                          child: const Icon(Icons.close, color: KColors.backgroundPrimary,),
                        )
                      ],
                    ),
                    dummyHeight(),
                    Text("Pilih Kategori", style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
                    dummyHeight(),
                  ],
                ),
              ),
            ),
          );
        }
      );
    }
    return _buildMenu(
      context: bottomSheetContext, 
      onTapped: prosesPengubahanKategoriWallet, 
      title: "Kategori",
      subtitle: "Salah pilih kategori wallet? sans bisa diubah kok",
      leading: const Icon(Icons.account_balance_wallet)
    );
  }

  KEventHandler   onTap       (BuildContext context){
    const divider = Divider(color: Colors.black45, height: 5,);
    showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (bottomSheetContext){
        return IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                judul(bottomSheetContext),
                dummyHeight(),
                divider,
                menuUbahNama(bottomSheetContext),
                divider,
                menuUbahKategori(bottomSheetContext),
                divider,
                menuHapusData(bottomSheetContext),
                divider,
              ],
            ),
          ),
        );
      }
    );
  }
  Widget          getWidget   (){
    return GestureDetector(
      onTap: (){
        onTap(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.more_vert, color: Colors.white,),
      ),
    );
  }
}