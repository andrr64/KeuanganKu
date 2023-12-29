import 'package:flutter/material.dart';
import 'package:keuanganku/enum/status.dart';

class KDialogInfo{
  final String title;
  final String info;
  final Pesan jenisPesan;
  BuildContext? dialogContext;
  List<Widget>? action;
  Function()? onCancel;
  Function()? onOk;
  String? okTitle;
  String? cancelTitle;

  KDialogInfo({
    required this.title,
    required this.info,
    required this.jenisPesan,
    this.action,
    this.onCancel,
    this.onOk,
    this.okTitle,
    this.cancelTitle
  });

  Widget buttonCancel(BuildContext context){
    return TextButton(
      onPressed: (){
        if (onCancel != null){
          onCancel!();
        }
        Navigator.pop(context);
      }, child: Text(cancelTitle?? "Cancel")
    );
  }
  Widget buttonOk(BuildContext context){
    return TextButton(
      onPressed: (){
        if (onOk != null){
          onOk!();
        }
        Navigator.pop(context);
      }, child: Text(okTitle ?? "Ok")
    );
  }

  List<Widget> getActionButton(BuildContext context){
    if (action != null){
      return action!;
    }
    else if (jenisPesan == Pesan.Konfirmasi){
      return [
        buttonOk(context),
        buttonCancel(context),
      ];
    }
    return [buttonOk(context)];
  }

  tampilkanDialog(BuildContext context){
    showDialog(context: context, builder: (_){
      dialogContext = _;
      return  AlertDialog(
        title: Text(title),
        content: Text(info),
        actions: getActionButton(_)
      );
    });
  }
}