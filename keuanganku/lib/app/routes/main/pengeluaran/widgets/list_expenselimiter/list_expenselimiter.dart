import 'package:flutter/material.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';

class ListExpenseLimiter extends StatefulWidget {
  const ListExpenseLimiter({super.key});

  @override
  State<ListExpenseLimiter> createState() => _ListExpenseLimiterState();
}

class _ListExpenseLimiterState extends State<ListExpenseLimiter> {
  @override
  Widget build(BuildContext context) {
    return KCard(
      title: "Pembatas Pengeluaran", 
      child: KEmpty()
    );
  }
}