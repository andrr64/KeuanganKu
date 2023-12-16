import 'package:flutter/material.dart';

Future<DateTime> tampilkanDatePicker({
  required BuildContext context,
  required DateTime waktuAwal,
  required DateTime waktuAkhir,
  required DateTime waktuInisialisasi,
}) async {
  return (await showDatePicker(
    context: context, 
    initialDate: waktuInisialisasi,
    firstDate: waktuAwal, 
    lastDate: waktuAkhir,
    initialEntryMode: DatePickerEntryMode.calendar 
  )) ?? waktuInisialisasi;
}