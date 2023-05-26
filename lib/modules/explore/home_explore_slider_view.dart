import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/splash/components/page_pop_view.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView(
      {Key? key, this.opValue = 0.0, required this.click})
      : super(key: key);
  @override
  HomeExploreSliderViewState createState() => HomeExploreSliderViewState();
}

class HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: Locs.alized.sekolah,
      subText: Locs.alized.five_star,
      assetsImage: LocalFiles.explore_1,
    ));
    pageViewModelData.add(PageViewData(
      titleText: Locs.alized.kota_tua,
      subText: Locs.alized.five_star,
      assetsImage: LocalFiles.explore_2,
    ));
    pageViewModelData.add(PageViewData(
      titleText: Locs.alized.monas,
      subText:  Locs.alized.five_star,
      assetsImage: LocalFiles.explore_3,
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        if (currentShowIndex == 0) {
          pageController.animateTo(MediaQuery.of(context).size.width,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 1) {
          pageController.animateTo(MediaQuery.of(context).size.width * 2,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 2) {
          pageController.animateTo(0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              PagePopup(
                imageData: pageViewModelData[0],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[1],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[2],
                opValue: widget.opValue,
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            right: Get.find<Locs>().isRTL ? null : 32,
            // left: 32,
            left: Get.find<Locs>().isRTL ? 32 : null,
            //     right: context.read<ThemeProvider>().languageType ==
            //             LanguageType.ar
            //         ? 32
            //         : null,
            child: SmoothPageIndicator(
                controller: pageController, // PageController
                count: 3,
                effect: WormEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Theme.of(context).dividerColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0), // your preferred effect
                onDotClicked: (index) {}),
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;

  const PagePopup({Key? key, required this.imageData, this.opValue = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData.assetsImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  imageData.titleText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context)
                      .getTitleStyle()
                      .copyWith(color: AppTheme.whiteColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  imageData.subText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.whiteColor),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
