import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({Key? key}) : super(key: key);

  @override
  InviteFriendState createState() => InviteFriendState();
}

class InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset(LocalFiles.inviteImage),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  Locs.alized.invite_your_friend,
                  style: TextStyles(context).getBoldStyle().copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Text(
                  Locs.alized.invite_friend_desc,
                  textAlign: TextAlign.center,
                  style: TextStyles(context).getRegularStyle().copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(
                      radius: 4,
                      buttonTextWidget: SizedBox(
                        height: 40,
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                Locs.alized.share_text,
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(color: AppTheme.whiteColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: <Widget>[appBar()],
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: SizedBox(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
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
      ),
    );
  }
}
