import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';

class ViewData extends StatefulWidget {

  final UserModel userModel;

  const ViewData({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AIRPA App"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
              title: const Text('ID User'),
              subtitle: Text(widget.userModel.uid),
              leading: const Icon(Icons.key)),
          ListTile(
              title: const Text("Nama Depan"),
              subtitle: Text(widget.userModel.firstName),
              leading: const Icon(Icons.verified_user)),
          ListTile(
              title: const Text("Nama Belakang"),
              subtitle: Text(widget.userModel.lastName),
              leading: const Icon(Icons.verified_user)),
          ListTile(
              title: const Text("Email"),
              subtitle: Text(widget.userModel.email!),
              leading: const Icon(Icons.email)),
          ListTile(
              title: const Text("No Handphone"),
              subtitle: Text(widget.userModel.phone.toString()),
              leading: const Icon(Icons.phone)),
        ],
      ),
    );
  }
}
