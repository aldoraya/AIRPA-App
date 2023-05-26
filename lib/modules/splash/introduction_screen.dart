import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/splash/components/page_pop_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);
  
  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: Locs.alized.diverse_selection,
      subText: Locs.alized.we_have_dozens,
      assetsImage: LocalFiles.introduction1,
    ));

    pageViewModelData.add(PageViewData(
      titleText: Locs.alized.rental_guarante,
      subText: Locs.alized.worried_about_your,
      assetsImage: LocalFiles.introduction2,
    ));

    pageViewModelData.add(PageViewData(
      titleText: Locs.alized.decide_to_your,
      subText: Locs.alized.family_event_or,
      assetsImage: LocalFiles.introduction3,
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              pageSnapping: true,
              onPageChanged: (index) {
                currentShowIndex = index;
              },
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                PagePopup(imageData: pageViewModelData[0]),
                PagePopup(imageData: pageViewModelData[1]),
                PagePopup(imageData: pageViewModelData[2]),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Theme.of(context).dividerColor,
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5.0),
            onDotClicked: (index) {},
          ),
           CommonButton(
            padding:
                const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 32),
            buttonText: Locs.alized.login,
            onTap: () {
              NavigationServices(context).gotoLoginScreen();
            },
          ),
          CommonButton(
            padding:
                const EdgeInsets.only(left: 48, right: 48, bottom: 32, top: 8),
            buttonText: Locs.alized.create_account,
            backgroundColor: AppTheme.backgroundColor,
            textColor: AppTheme.primaryColor,
            onTap: () {
              NavigationServices(context).gotoSignScreen();
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}
