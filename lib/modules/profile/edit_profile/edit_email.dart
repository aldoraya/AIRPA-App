import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/widgets/appbar_widget.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/modules/admin/users/db_services.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  final UserModel? userModel;

  const EditEmailFormPage({Key? key, this.userModel}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _auth = FirebaseAuth.instance;
 
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser!;

    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 320,
                    child: Text(
                      "Email Anda apa?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silahkan masukan email Anda.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Alamat email Anda'),
                          controller: _emailController,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: CommonButton(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 8),
                              buttonText: "Update",
                              onTap: () {
                                final dt =
                                    UserModel(
                                      uid: user.uid,
                                      email: _emailController.text
                                      );
                                Database.ubahData(ubahUser: dt);
                                Navigator.pop(context);
                              }),
                        )))
              ]),
        ));
  }
}
