import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'db_services.dart';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditData extends StatefulWidget {
  final UserModel? userModel;
  const EditData({Key? key, this.userModel}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isDisabled = false;

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _firstNameController.text = widget.userModel?.firstName ?? "";
    _lastNameController.text = widget.userModel?.lastName ?? "";
    _emailController.text = widget.userModel?.email ?? "";
    _phoneController.text = widget.userModel?.phone.toString() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userModel == null) _isDisabled = true;
     User? user = _auth.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                enabled: _isDisabled,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama Depan'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama Belakang'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'No Handphone'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              CommonButton(
                onTap: () {
                  final dt = UserModel(
                      uid: user.uid,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      phone: _phoneController.hashCode);
                  Database.ubahData(ubahUser: dt);
                  Navigator.pop(context);
                },
                buttonText: 'Simpan Data',
              ),
            ],
          ),
        ));
  }
}
