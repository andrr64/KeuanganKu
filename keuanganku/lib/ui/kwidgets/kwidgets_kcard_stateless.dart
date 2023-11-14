import 'package:keuanganku/ui/kwidgets/kcard_stateless.dart';

abstract class KWidgetsStatelessCard {
  late KCardStateless widget;

  getChild();
  init({dynamic parameters});
  getWidget({dynamic parameters});
}