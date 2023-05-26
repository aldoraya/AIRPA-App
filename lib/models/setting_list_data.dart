import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';

class SettingsListData {
  String titleTxt;
  String subTxt;
  IconData iconData;
  bool isSelected;

  SettingsListData({
    this.titleTxt = '',
    this.isSelected = false,
    this.subTxt = '',
    this.iconData = Icons.supervised_user_circle,
  });

  List<SettingsListData> getCountryListFromJson(Map<String, dynamic> json) {
    List<SettingsListData> countryList = [];
    if (json['countryList'] != null) {
      json['countryList'].forEach((v) {
        SettingsListData data = SettingsListData();
        data.titleTxt = v["name"];
        data.subTxt = v["code"];
        countryList.add(data);
      });
    }
    return countryList;
  }

  static List<SettingsListData> get userSettingsList => [
        SettingsListData(
          titleTxt: Locs.alized.change_password,
          isSelected: false,
          iconData: FontAwesomeIcons.lock,
        ),
        SettingsListData(
          titleTxt: Locs.alized.invite_friend,
          isSelected: false,
          iconData: FontAwesomeIcons.userGroup,
        ),
        SettingsListData(
          titleTxt: Locs.alized.credit_coupons,
          isSelected: false,
          iconData: FontAwesomeIcons.gift,
        ),
        SettingsListData(
          titleTxt: Locs.alized.help_center,
          isSelected: false,
          iconData: FontAwesomeIcons.circleInfo,
        ),
        SettingsListData(
          titleTxt: Locs.alized.payment_text,
          isSelected: false,
          iconData: FontAwesomeIcons.wallet,
        ),
        SettingsListData(
          titleTxt: Locs.alized.setting_text,
          isSelected: false,
          iconData: FontAwesomeIcons.gear,
        )
      ];

 static List<SettingsListData> get settingsList => [
        SettingsListData(
          titleTxt: Locs.alized.theme_mode,
          isSelected: false,
          iconData: FontAwesomeIcons.skyatlas,
        ),
        SettingsListData(
          titleTxt: Locs.alized.fonts,
          isSelected: false,
          iconData: FontAwesomeIcons.font,
        ),
        SettingsListData(
          titleTxt: Locs.alized.color,
          isSelected: false,
          iconData: Icons.color_lens,
        ),
        SettingsListData(
          titleTxt: Locs.alized.language,
          isSelected: false,
          iconData: Icons.translate_outlined,
        ),
        SettingsListData(
          titleTxt: "Apakah anda admin?",
          isSelected: false,
          iconData: FontAwesomeIcons.user,
        ),
        SettingsListData(
          titleTxt: Locs.alized.log_out,
          isSelected: false,
          iconData: Icons.logout,
        )
      ];

  static List<SettingsListData> helpSearchList = [
    SettingsListData(
      titleTxt: Locs.alized.paying_for_a_reservation,
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.how_do_i,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.what_methods,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.when_am_i_charged,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.how_do_i_edit,
    ),
    SettingsListData(
      titleTxt: Locs.alized.trust_and_safety,
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.i_m_a_guest_what,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.when_am_i_charged,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.how_do_i_edit,
    ),
 SettingsListData(
      titleTxt: Locs.alized.paying_for_a_reservation,
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.how_do_i,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.what_methods,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.when_am_i_charged,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.how_do_i_edit,
    ),
    SettingsListData(
      titleTxt: Locs.alized.trust_and_safety,
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.i_m_a_guest_what,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.when_am_i_charged,
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: Locs.alized.how_do_i_edit,
    ),
  ];

  static List<SettingsListData> subHelpList = [
    SettingsListData(titleTxt: "", subTxt: Locs.alized.you_can_cancel),
    SettingsListData(
      titleTxt: "",
      subTxt: Locs.alized.go_to_trips_and_choose_yotr_trip,
    ),
    SettingsListData(titleTxt: "", subTxt: Locs.alized.you_be_taken_to),
    SettingsListData(titleTxt: "", subTxt: Locs.alized.if_you_cancel_your),
    SettingsListData(
      titleTxt: "",
      subTxt: Locs.alized.give_feedback,
      isSelected: true,
    ),
    SettingsListData(
      titleTxt: Locs.alized.related_articles,
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: Locs.alized.can_i_change,
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: Locs.alized.how_do_i_cancel,
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: Locs.alized.what_is_the,
    ),
  ];

  static List<SettingsListData> userInfoList = [
    SettingsListData(
      titleTxt: '',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: 'Username',
      subTxt: "Aldo Raya Al Hakim",
    ),
    SettingsListData(
      titleTxt: 'Email',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: 'phone',
      subTxt: "+62",
    ),
    SettingsListData(
      titleTxt: 'Tanggal Lahir',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: 'Alamat',
      subTxt: "",
    ),
  ];
}