import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/app/reusable_widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_pemasukan_item/k_pemasukan_item.dart';
import 'package:keuanganku/database/model/data_pemasukan.dart';

class KListPemasukan extends StatefulWidget {
  const KListPemasukan({super.key, required this.listPemasukan, required this.callback});
  final List<SQLModelPemasukan> listPemasukan;
  final VoidCallback callback;
  
  @override
  State<KListPemasukan> createState() => KListPemasukanState();
}

class KListPemasukanState extends State<KListPemasukan> {
  Widget buildBody(BuildContext context){
    final size = MediaQuery.sizeOf(context);

    if (widget.listPemasukan.isEmpty){
      return const KEmpty();
    }
    return Column(
      children: [
        for(int i = 0; i < widget.listPemasukan.length; i++)
          KPemasukanItem(size: size, pemasukan: widget.listPemasukan[i])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final icon = SvgPicture.asset("assets/icons/pemasukan.svg");
    return KCard(
      title: "Pemasukan",
      icon: icon,
      width: size.width * 0.875, 
      child: buildBody(context)
    );
  }
}
