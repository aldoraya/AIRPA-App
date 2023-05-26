import 'dart:io';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penyewaan_gedung_app/widgets/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/modules/admin/users/db_services.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  EditImagePageState createState() => EditImagePageState();
}

class EditImagePageState extends State<EditImagePage> {
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser!;

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
              width: 330,
              child: Text(
                "Upload foto profile:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final imageFile = File('${location.path}/$image');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                      setState(() => loggedInUser =
                          loggedInUser.copy(imagePath: newImage.path));
                    },
                    child: Image.network(loggedInUser.image),
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: CommonButton(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                      buttonText: "Update",
                      onTap: () {
                        final dt =
                              UserModel(
                                  uid: user.uid,
                                image: loggedInUser.image);
                            Database.ubahData(ubahUser: dt);
                            Navigator.pop(context);
                      },
                    ),
                  )))
        ],
      ),
    );
  }
}
