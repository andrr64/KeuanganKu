import 'package:keuanganku/enum/build_mode.dart';
import 'package:keuanganku/main.dart';

class ApplicationInfo {
  static const String stringAppVersion = "$appMajorVersion.$appMinorVersion.$appPatchVersion";
  static const String title = "KeuanganKu";
  static const int appMajorVersion = 0;
  static const int appMinorVersion = 1;
  static const int appPatchVersion = 0;
  static const BuildMode appBuildMode = BuildMode.Debug;
  static String get buildMode => appBuildMode.enumValue;
}