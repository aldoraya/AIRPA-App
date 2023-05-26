import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/search_view.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/common_search_bar.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<GedungListData> lastsSearchesList = GedungListData.lastsSearchesList;

  late AnimationController animationController;
  final myController = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: Locs.alized.search_building,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 16, bottom: 16),
                          child: CommonCard(
                            color: AppTheme.backgroundColor,
                            radius: 36,
                            child: CommonSearchBar(
                              textEditingController: myController,
                              iconData: FontAwesomeIcons.magnifyingGlass,
                              enabled: true,
                              text: Locs.alized.where_do_you,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  Locs.alized.last_search,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  onTap: () {
                                    setState(() {
                                      myController.text = '';
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          Locs.alized.clear_all,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ] +
                      getPList(myController.text.toString()) +
                      [
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16,
                        )
                      ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getPList(String serachValue) {
    List<Widget> noList = [];
    var cout = 0;
    const columCount = 2;
    for (var i = 0; i < lastsSearchesList.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = lastsSearchesList[cout];
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / lastsSearchesList.length) * cout, 1.0,
                  curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          listUI.add(Expanded(
            child: SerchView(
              gedungInfo: date,
              animation: animation,
              animationController: animationController,
            ),
          ));
          cout += 1;
        } catch (_) {}
      }
      noList.add(
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: listUI,
          ),
        ),
      );
    }
    return noList;
  }
}
