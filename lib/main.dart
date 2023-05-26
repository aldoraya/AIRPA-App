import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/logic/controllers/google_map_pin_controller.dart';
import 'package:penyewaan_gedung_app/logic/controllers/theme_provider.dart';
import 'package:penyewaan_gedung_app/gedung_app.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<Locs>(() =>Locs().init(), permanent: true);

  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const GedungApp()));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GedungApp());
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapPinController>(GoogleMapPinController());
  }
}
