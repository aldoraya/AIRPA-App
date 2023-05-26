import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:penyewaan_gedung_app/widgets/appbar_widget.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/modules/admin/users/db_services.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  final UserModel? userModel;

  const EditNameFormPage({Key? key, this.userModel}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  int _jumlah = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                      width: 330,
                      child: Text(
                        "Nama Anda siapa?",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                          child: SizedBox(
                              height: 100,
                              width: 150,
                              child: TextFormField(
                                // Handles Form Validation for First Name
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Silahkan masukan nama depan Anda';
                                  } else if (!isAlpha(value)) {
                                    return 'Hanya huruf Silahkan';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Nama Depan'),
                                controller: _firstNameController,
                              ))),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                          child: SizedBox(
                              height: 100,
                              width: 150,
                              child: TextFormField(
                                // Handles Form Validation for Last Name
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Silahkan masukan nama Anda';
                                  } else if (!isAlpha(value)) {
                                    return 'Hanya huruf silahkan';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Nama Akhir'),
                                controller: _lastNameController,
                              )))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: 330,
                            height: 50,
                            child: CommonButton(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, bottom: 8),
                                buttonText: "Update",
                                onTap: () {
                                  _jumlah++;
                                  final dt = UserModel(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text);
                                  Database.ubahData(ubahUser: dt);
                                  Navigator.pop(context);
                                })),
                      ))
                ])));
  }
}
