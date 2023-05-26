import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/favorites_list_view.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/finish_book_view.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/upcoming_list_view.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/bottom_top_move_animation_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';

class MyReservationScreen extends StatefulWidget {
  final AnimationController animationController;

  const MyReservationScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  MyReservationScreenState createState() => MyReservationScreenState();
}

class MyReservationScreenState extends State<MyReservationScreen>
    with TickerProviderStateMixin {
  late AnimationController tabAnimationController;

  Widget indexView = Container();
  TopBarType topBarType = TopBarType.upcoming;

  @override
  void initState() {
    tabAnimationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    indexView = UpcomingListView(
      animationController: tabAnimationController,
    );
    tabAnimationController.forward();
    widget.animationController.forward();

    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    tabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(child: _getappBar()),
          ),
          //upcoming finished favorites selected
          tabViewUI(topBarType),
          //hotel list view
          Expanded(
            child: indexView,
          ),
        ],
      ),
    );
  }

  void tabClick(TopBarType tabType) {
    if (tabType != topBarType) {
      topBarType = tabType;
      tabAnimationController.reverse().then((f) {
        if (tabType == TopBarType.upcoming) {
          setState(() {
            indexView = UpcomingListView(
              animationController: tabAnimationController,
            );
          });
        } else if (tabType == TopBarType.finished) {
          setState(() {
            indexView = FinishTripView(
              animationController: tabAnimationController,
            );
          });
        } else if (tabType == TopBarType.favorites) {
          setState(() {
            indexView = FavoritesListView(
              animationController: tabAnimationController,
            );
          });
        }
      });
    }
  }

  Widget tabViewUI(TopBarType tabType) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CommonCard(
        color: AppTheme.backgroundColor,
        radius: 36,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _getTopBarUi(() {
                  tabClick(TopBarType.upcoming);
                },
                    tabType == TopBarType.upcoming
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryTextColor,
                   Locs.alized.upcoming),
                _getTopBarUi(() {
                  tabClick(TopBarType.finished);
                },
                    tabType == TopBarType.finished
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryTextColor,
                     Locs.alized.finished),
                _getTopBarUi(() {
                  tabClick(TopBarType.favorites);
                },
                    tabType == TopBarType.favorites
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryTextColor,
                    Locs.alized.favorites),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget _getTopBarUi(VoidCallback onTap, Color color, String text) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Center(
              child: Text(
                text,
                style: TextStyles(context)
                    .getRegularStyle()
                    .copyWith(fontWeight: FontWeight.w600, color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getappBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24 + 4.0, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Locs.alized.my_reservation,
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 22)),
        ],
      ),
    );
  }
}

enum TopBarType { upcoming, finished, favorites }
