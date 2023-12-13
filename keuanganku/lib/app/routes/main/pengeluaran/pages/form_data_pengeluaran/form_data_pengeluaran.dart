import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable%20widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/reusable%20widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/util/dummy.dart';

class FormDataPengeluaran extends StatefulWidget {
  const FormDataPengeluaran({super.key, required this.onSaveCallback, required this.listWallet});
  final VoidCallback onSaveCallback;
  final List<SQLModelWallet> listWallet;
  
  @override
  State<FormDataPengeluaran> createState() => _FormDataPengeluaranState();
}

class _FormDataPengeluaranState extends State<FormDataPengeluaran> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  SQLModelWallet? walletTerpilih;  

  Widget fieldJudul(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJudul, 
        fieldName: "Judul Pengeluaran", 
        icon: Icons.title_sharp,
        prefixIconColor: ApplicationColors.primary  ),
    );
  }
  Widget fieldJumlah(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJumlah, 
        fieldName: "Jumlah Pengeluaran", 
        icon: Icons.attach_money,
        keyboardType: TextInputType.number,
        prefixIconColor: ApplicationColors.primary),
    );
  }
  Widget dropDownMenuWallet(List<SQLModelWallet> listWallet){
    walletTerpilih ??= listWallet[0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KDropdownMenu<SQLModelWallet>(
        items: listWallet.map((e){
          return DropdownMenuItem<SQLModelWallet>(
            value: e,
            child: Row(
              children: [
                Icon(e.tipe == "Wallet"? Icons.wallet : Icons.account_balance),
                const SizedBox(width: 10,),
                Text(e.judul)
              ],
            )
          );
        }).toList(), 
        onChanged: (val){
          walletTerpilih = val;
        }, 
        value: walletTerpilih!, 
        labelText: "Wallet"
      ).getWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.90,
      height: size.height * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Column(
        children: [
          dummyPadding(height: 50),
          fieldJudul(),
          dummyPadding(height: 25),
          fieldJumlah(),
          dummyPadding(height: 25),
          dropDownMenuWallet(widget.listWallet),
        ]
      )
    );
  }
}
