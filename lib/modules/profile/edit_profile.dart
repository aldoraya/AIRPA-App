import 'package:flutter/material.dart';
import 'dart:async';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/display_image_widget.dart';
import '../../models/setting_list_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/modules/profile/edit_profile/edit_phone.dart';
import 'package:penyewaan_gedung_app/modules/profile/edit_profile/edit_email.dart';
import 'package:penyewaan_gedung_app/modules/profile/edit_profile/edit_name.dart';
import 'package:penyewaan_gedung_app/modules/profile/edit_profile/edit_image.dart';
import 'package:penyewaan_gedung_app/widgets/appbar_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  List<SettingsListData> userInfoList = SettingsListData.userInfoList;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var fullName = UserModel();
    fullName.firstName = loggedInUser.firstName;
    fullName.lastName = loggedInUser.lastName;
    fullName.name = "${loggedInUser.firstName} ${loggedInUser.lastName}";

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
         children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
          const Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Ubah Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          InkWell(
              onTap: () {
                navigateSecondPage(const EditImagePage());
              },
              child: DisplayImage(
                imagePath: loggedInUser.image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(
              fullName.name!, 'Nama', const EditNameFormPage()),
          buildUserInfoDisplay(
              loggedInUser.phone.toString(), 'Nomer Hp', const EditPhoneFormPage()),
          buildUserInfoDisplay(
              loggedInUser.email!, 'Email', const EditEmailFormPage()),
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 16, 
                                height: 1.4,
                                color: Colors.black)
                                ,
                            ))),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
            width: 350,
            height: 200,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ))),
          )
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
