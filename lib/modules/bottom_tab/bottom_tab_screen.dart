import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/explore/home_explore.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/my_reservation_screen.dart';
import 'package:penyewaan_gedung_app/modules/profile/profile_screen.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/components/tab_button_ui.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.explore;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExploreScreen(
        animationController: _animationController,
      );
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60 + MediaQuery.of(context).padding.bottom,
        child: getBottomBarUI(bottomBarType),
      ),
      body: _isFirstTime
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : _indexView,
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        if (tabType == BottomBarType.explore) {
          setState(() {
            _indexView = HomeExploreScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.reservation) {
          setState(() {
            _indexView = MyReservationScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.profile) {
          setState(() {
            _indexView = ProfileScreen(
              animationController: _animationController,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TabButtonUI(
                icon: Icons.search,
                isSelected: tabType == BottomBarType.explore,
                text: Locs.alized.explore,
                onTap: () {
                  tabClick(BottomBarType.explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.heart,
                isSelected: tabType == BottomBarType.reservation,
                text: Locs.alized.reservation,
                onTap: () {
                  tabClick(BottomBarType.reservation);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: tabType == BottomBarType.profile,
                text: Locs.alized.profile,
                onTap: () {
                  tabClick(BottomBarType.profile);
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}

enum BottomBarType { explore, reservation, profile }
