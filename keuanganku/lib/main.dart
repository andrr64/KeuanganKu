import 'package:flutter/material.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/database_services.dart';
import 'package:keuanganku/android_system.dart';
import 'package:keuanganku/app/routes.dart';
import 'package:keuanganku/database/helper/user_data.dart';


extension EnumToString on Enum {
  String get enumValue => toString().split('.').last;
}

Routes routes = Routes();
DatabaseService db = DatabaseService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidSys.setNotificationBarColor(
      bgColor: Colors.transparent,
      iconColor: Brightness.light,
      navbarColor: Colors.black,
      navBarIconColor: Brightness.light
  ); // Berfungsi untuk mengubah warna bar notifikasi android
  db.openDB().then((value){
    runApp(const KeuanganKu());
  });
}

class KeuanganKu extends StatelessWidget {
  const KeuanganKu({super.key});

  ThemeData get tema => ThemeData(
    appBarTheme: const AppBarTheme(elevation: 0),
  );

  Future<String> inisialisasiRute() async {
    final userData = await SQLHelperUserData().readById(db.database, 1);
    if (userData?.username == null){
      return routes.gettingStarted;
    }
    return routes.mainPage;
  }

  @override
  Widget build(BuildContext context) {
    routes.initializePages(context);
    return KFutureBuilder.build(
        future: inisialisasiRute(),
        whenError: const CircularProgressIndicator(),
        whenSuccess: (rute){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'KeuanganKu',
            routes: routes.routeMap,
            initialRoute: rute,
          );
        });
  }
}