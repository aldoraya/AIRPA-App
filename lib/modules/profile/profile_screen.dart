import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/bottom_top_move_animation_view.dart';
import '../../models/setting_list_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  User user = FirebaseAuth.instance.currentUser!;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;

    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(child: appBar()),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: userSettingsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    //setting screen view
                    if (index == 5) {
                      NavigationServices(context).gotoSettingsScreen();

                      //   setState(() {});
                    }
                    //help center screen view

                    if (index == 3) {
                      NavigationServices(context).gotoHeplCenterScreen();
                    }
                    //Chage password  screen view

                    if (index == 0) {
                      NavigationServices(context).gotoChangepasswordScreen();
                    }
                    //Invite friend  screen view

                    if (index == 1) {
                      NavigationServices(context).gotoInviteFriend();
                    }
                  },
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
                                  userSettingsList[index].titleTxt,
                                  style: TextStyles(context)
                                      .getRegularStyle()
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(userSettingsList[index].iconData,
                                  color: AppTheme.secondaryTextColor
                                      .withOpacity(0.7)),
                            )
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
    );
  }

  Widget appBar() {
    return InkWell(
      onTap: () async {
        await NavigationServices(context).gotoEditProfile();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${loggedInUser.firstName} ${loggedInUser.lastName}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    Locs.alized.view_edit,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
            child: SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                child: Image.asset(LocalFiles.userImage),
              ),
            ),
          )
        ],
      ),
    );
  }
}