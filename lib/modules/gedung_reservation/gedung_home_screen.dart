import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/components/filter_bar_ui.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/components/map_and_list_view.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/components/time_date_view.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/gedung_list_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/common_search_bar.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import '../../models/gedung_list_data.dart';

class GedungHomeScreen extends StatefulWidget {
  
  const GedungHomeScreen({Key? key}) : super(key: key);

  @override
  State<GedungHomeScreen> createState() => _GedungHomeScreenState();
}

class _GedungHomeScreenState extends State<GedungHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _animationController;
  var gedungList = GedungListData.gedungList;

  ScrollController scrollController = ScrollController();
  int room = 1;
  int ad = 2;
  DateTime startDate  = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  bool _isShowMap = false;

  final searchBarHieght = 158.0;
  final filterBarHieght = 52.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        _animationController.animateTo(0.0);
      } else if (scrollController.offset > 0.0 &&
          scrollController.offset < searchBarHieght) {
        // we need around searchBarHieght scrolling values in 0.0 to 1.0
        _animationController
            .animateTo((scrollController.offset / searchBarHieght));
      } else {
        _animationController.animateTo(1.0);
      }
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          RemoveFocuse(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                _getAppBarUI(),
                _isShowMap
                    ? MapAndListView(
                        gedungList: gedungList,
                        searchBarUI: _getSearchBarUI(),
                      )
                    : Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: AppTheme.scaffoldBackgroundColor,
                              child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: gedungList.length,
                                  padding: const EdgeInsets.only(
                                    top: 8 + 158 + 52.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return getListView(index);
                                  }),
                            ),
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (BuildContext context, Widget? child) {
                                return Positioned(
                                  top: -searchBarHieght *
                                      (_animationController.value),
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Column(
                                          children: <Widget>[
                                            //Gedung search view
                                            _getSearchBarUI(),
                                            // time date and number of rooms view
                                            const TimeDateView(),
                                          ],
                                        ),
                                      ),
                                      //Gedung price & facilitate  & distance
                                      const FilterBarUI(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 8, top: 8, bottom: 8, left: 8),
              child: CommonCard(
                color: AppTheme.backgroundColor,
                radius: 36,
                child: const CommonSearchBar(
                  enabled: true,
                  ishsow: false,
                  text: "Masukan nama gedung",
                ),
              ),
            ),
          ),
          CommonCard(
            color: AppTheme.primaryColor,
            radius: 36,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  NavigationServices(context).gotoSearchScreen();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20, color: AppTheme.backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Get.find<Locs>().isRTL
                ? Alignment.centerRight
                : Alignment.centerLeft,
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                Locs.alized.explore,
                style: TextStyles(context).getTitleStyle(),
              ),
            ),
          ),
          SizedBox(
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite_border),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      setState(() {
                        _isShowMap = !_isShowMap;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(_isShowMap
                          ? Icons.sort
                          : FontAwesomeIcons.mapLocationDot),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

   Widget getListView(int index) {
    var gedungList = GedungListData.gedungList;
    List<Widget> list = [];
    for (var f in gedungList) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      animationController.forward();
      list.add(
        GedungListView(
          callback: () {
            NavigationServices(context).gotoGedungDetailes(f);
          },
          gedungData: f,
          animation: animation,
          animationController: animationController,
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
}
