import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/common_search_bar.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/setting_list_data.dart';

class HelpCenterScreen extends StatefulWidget {
   const HelpCenterScreen({Key? key})
      : super(key: key);
      
  @override
  HelpCenterScreenState createState() => HelpCenterScreenState();
}

class HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    List<SettingsListData> helpSearchList = SettingsListData.helpSearchList;
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: appBar(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                itemCount: helpSearchList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: helpSearchList[index].subTxt != ""
                        ? () {
                            NavigationServices(context).gotoHowDoScreen();
                          }
                        : null,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    helpSearchList[index].titleTxt != ""
                                        ? helpSearchList[index].titleTxt
                                        : helpSearchList[index].subTxt,
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                            fontWeight: helpSearchList[index]
                                                        .titleTxt !=
                                                    ""
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: helpSearchList[index]
                                                        .titleTxt !=
                                                    ""
                                                ? 18
                                                : 14),
                                  ),
                                ),
                              ),
                              helpSearchList[index].subTxt != ""
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Icon(Icons.keyboard_arrow_right,
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.3)),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Divider(
                            height: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonAppbarView(
          onBackClick: () {
            Navigator.pop(context);
          },
          iconData: Icons.arrow_back,
          titleText: Locs.alized.how_can_help_you,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 36,
              child: CommonSearchBar(
                iconData: FontAwesomeIcons.magnifyingGlass,
                text: Locs.alized.search_help_artical,
              ),
            )),
      ],
    );
  }
}