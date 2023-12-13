import 'package:flutter/material.dart';

Future<TimeOfDay> tampilkanTimePicker({required BuildContext context, required TimeOfDay waktu}) async {
  return (
    await showTimePicker(
      context: context, 
      initialTime: waktu,
      initialEntryMode: TimePickerEntryMode.inputOnly
    )
  ) ?? waktu;
}