import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/modules/explore/home_explore_slider_view.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/gedung_list_view_page.dart';
import 'package:penyewaan_gedung_app/modules/explore/popular_list_view.dart';
import 'package:penyewaan_gedung_app/modules/explore/title_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/bottom_top_move_animation_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/common_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeExploreScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  HomeExploreScreenState createState() => HomeExploreScreenState();
}

class HomeExploreScreenState extends State<HomeExploreScreen>
    with TickerProviderStateMixin {
  var gedungList = GedungListData.gedungList;
  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHieght = 0.0;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if (mounted) {
        if (controller.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHieght) {
          // we need around half scrolling values
          if (controller.offset < ((sliderImageHieght / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHieght));
          } else {
            // we static set the just above half scrolling values "around == 0.64"
            _animationController
                .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Stack(
        children: <Widget>[
          Container(
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView.builder(
              controller: controller,
              itemCount: 4,
              // padding on top is only for we need spec for sider
              padding: EdgeInsets.only(top: sliderImageHieght + 32, bottom: 16),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                // some list UI
                var count = 4;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                if (index == 0) {
                  return TitleView(
                    titleTxt: Locs.alized.popular_city,
                    subTxt: '',
                    animation: animation,
                    animationController: widget.animationController,
                    click: () {},
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    //Popular Destinations animation view
                    child: PopularListView(
                      animationController: widget.animationController,
                      callBack: (index) {},
                    ),
                  );
                } else if (index == 2) {
                  return TitleView(
                    titleTxt: Locs.alized.best_deal,
                    subTxt: Locs.alized.view_all,
                    animation: animation,
                    isLeftButton: true,
                    animationController: widget.animationController,
                    click: () {
                      NavigationServices(context).gotoGedungHomeScreen();
                    },
                  );
                } else {
                  return getDealListView(index);
                }
              },
            ),
          ),
          // sliderUI with 3 images are moving
          sliderUI(),

          // viewGedung Button UI for click event
          viewGedungButton(_animationController),

          //just gradient for see the time and battry Icon on "TopBar"
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).backgroundColor.withOpacity(0.4),
                  Theme.of(context).backgroundColor.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
          ),
          //   serachUI on Top  Positioned
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: serachUI(),
          )
        ],
      ),
    );
  }

  Widget viewGedungButton(AnimationController animationController) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        var opecity = 1.0 -
            (_animationController.value > 0.64
                ? 1.0
                : _animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHieght * (1.0 - _animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: Get.find<Locs>().isRTL ? null : 24,
                right: Get.find<Locs>().isRTL ? 24 : null,
                child: Opacity(
                  opacity: opecity,
                  child: CommonButton(
                    onTap: () {
                      if (opecity != 0) {
                        NavigationServices(context).gotoGedungHomeScreen();
                      }
                    },
                    buttonTextWidget: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        Locs.alized.view_building,
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          // we calculate the opecity between 0.64 to 1.0
          var opecity = 1.0 -
              (_animationController.value > 0.64
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: sliderImageHieght * (1.0 - _animationController.value),
            child: HomeExploreSliderView(
              opValue: opecity,
              click: () {},
            ),
          );
        },
      ),
    );
  }

  Widget getDealListView(int index) {
    var gedungList = GedungListData.gedungList;
    List<Widget> list = [];
    for (var f in gedungList) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      list.add(
        GedungListViewPage(
          callback: () {
            NavigationServices(context).gotoGedungDetailes(f);
          },
          gedungData: f,
          animation: animation,
          animationController: widget.animationController,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: list,
      ),
    );
  }

  Widget serachUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(38)),
          onTap: () {
            NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.magnifyingGlass,
            color: AppTheme.primaryColor,
            enabled: false,
            text: Locs.alized.where_do_you,
          ),
        ),
      ),
    );
  }
}
