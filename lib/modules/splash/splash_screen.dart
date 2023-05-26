import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/logic/controllers/theme_provider.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadAppLocalizations());

    super.initState();
  }

  Future<void> _loadAppLocalizations() async {
    try {
      // load semua data json file to allLanguageTextDate
      // await appLocalizations.init(context);
      setState(() => {isLoadText = true});
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: !Get.find<ThemeController>().isLightMode
                ? BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.4))
                : null,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(LocalFiles.introduction, fit: BoxFit.cover),
          ),
          Column(
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Center(
                child: Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Theme.of(context).dividerColor,
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: Image.asset(LocalFiles.appIcon),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "AIRPA",
                textAlign: TextAlign.left,
                style: TextStyles(context).getBoldStyle().copyWith(
                      fontSize: 24,
                      color: AppTheme.goldColor,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 420),
                child: Text(
                  Locs.alized.best_building_deals,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(
                        color: AppTheme.whiteColor,
                      ),
                ),
              ),
              const Expanded(
                flex: 4,
                child: SizedBox(),
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.only(
                      left: 48, right: 48, bottom: 8, top: 8),
                  buttonText: Locs.alized.get_started,
                  onTap: () {
                    NavigationServices(context).gotoIntroductionScreen();
                  },
                ),
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                      top: 16),
                child: InkWell(
                onTap: () {
                  NavigationServices(context).gotoLoginScreen();
                },
                child: Text(
                  Locs.alized.already_have_account,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getDescriptionStyle().copyWith(
                        color: AppTheme.whiteColor,
                      ),
                ),
                ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
