import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penyewaan_gedung_app/common/common.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/logic/controllers/theme_provider.dart';
import 'package:penyewaan_gedung_app/main.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:penyewaan_gedung_app/modules/login/login_screen.dart';
import 'package:penyewaan_gedung_app/modules/splash/introduction_screen.dart';
import 'package:penyewaan_gedung_app/modules/splash/splash_screen.dart';
import 'package:penyewaan_gedung_app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:penyewaan_gedung_app/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class GedungApp extends StatefulWidget {
  const GedungApp({Key? key}) : super(key: key);

  @override
  State<GedungApp> createState() => _GedungAppState();
}

class _GedungAppState extends State<GedungApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Locs>(
      builder: (locController) {
        return GetBuilder<ThemeController>(
          builder: (controller) {
            final ThemeData theme = AppTheme.getThemeData;
            return GetMaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: const [
                Locale('id'), // Indonesian
                Locale('en'), // English
                Locale('fr'), // French
                Locale('ja'), // Japanises
                Locale('ar'), // Arebic
              ],
              navigatorKey: navigatorKey,
              locale: locController.locale,
              title: 'AIRPA App',
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: FutureBuilder(
                future: Firebase.initializeApp(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        return snapshot.hasData ? 
                        const BottomTabScreen() : const SplashScreen();
                      },
                    );
                  } else {
                    return const Text('');
                  }
                }),
              // routes: _buildRoutes(),
              initialBinding: AppBinding(),
              builder: (BuildContext context, Widget? child) {
                _setFirstTimeSomeData(context, theme);
                return Directionality(
                  textDirection: locController.locale.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: MediaQuery(
                    key: ValueKey(
                        'languageCode ${locController.locale.languageCode}'),
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).size.width > 360
                          ? 1.0
                          : MediaQuery.of(context).size.width >= 340
                              ? 0.9
                              : 0.8,
                    ),
                    child: child ?? const SizedBox(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

// when this application open every time on that time we check and update some theme data
  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    _setStatusBarNavigationBarTheme(theme);
    //we call some theme basic data set in app like color, font, theme mode, language
    Get.find<ThemeController>()
        .checkAndSetThemeMode(MediaQuery.of(context).platformBrightness);
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.backgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.splash: (BuildContext context) => const SplashScreen(),
      RoutesName.introductionScreen: (BuildContext context) =>
          const IntroductionScreen(),
      RoutesName.home: (BuildContext context) => const BottomTabScreen(),
      RoutesName.login: (BuildContext context) => const LoginScreen(),
      RoutesName.auth: (BuildContext context) => const AuthPage(),
    };
  }
}