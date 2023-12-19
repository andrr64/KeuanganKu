import 'package:flutter/material.dart';
import 'package:keuanganku/database/database_services.dart';
import 'package:keuanganku/android_system.dart';
import 'package:keuanganku/app/routes.dart';
import 'package:keuanganku/database/helper/user_data.dart';

typedef KEventHandler = void;

extension EnumToString on Enum {
  String get enumValue => toString().split('.').last;
}

Routes routes = Routes();
DatabaseService db = DatabaseService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidSys.setNotificationBarColor(
    bgColor: Colors.transparent,
    iconColor: Brightness.light,
    navbarColor: Colors.black,
    navBarIconColor: Brightness.light
  ); // Berfungsi untuk mengubah warna bar notifikasi android
  await db.openDB();
  runApp(const KeuanganKu());
}

class KeuanganKu extends StatelessWidget {
  const KeuanganKu({super.key});

  ThemeData get tema => ThemeData(
    appBarTheme: const AppBarTheme(elevation: 0),
  );

  Future<String> inisialisasiRute() async {
    final listUsername = await SQLHelperUserData().readAll(db.database);
    if (listUsername[0].username == null){
      return routes.gettingStarted;
    } 
    return routes.mainPage;
  }

  @override
  Widget build(BuildContext context) {
    
    routes.initializePages(context);
    return FutureBuilder(
      future: inisialisasiRute(), 
      builder: (_, snapshot){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KeuanganKu',
          routes: routes.routeMap, 
          initialRoute: snapshot.data!,
          theme: tema,
        );
      }
    );
  }
}