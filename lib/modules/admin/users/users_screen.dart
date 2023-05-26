import 'edit_data.dart';
import 'view_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'db_services.dart';

class UsersScreen extends StatefulWidget {
  final UserModel? userModel;

  const UsersScreen({Key? key, this.userModel}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _searchText = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool _isDisabled = false;

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchText.addListener(onSearch);
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return Database.getData(_searchText.text);
  }

  int _jumlah = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.userModel == null) _isDisabled = true;
    User? user = _auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Data User"),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(8, 20, 8, 8),
          child: Column(
            children: [
              TextField(
                controller: _searchText,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.yellow),
                    )),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: onSearch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('ERROR');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            DocumentSnapshot dsData =
                                snapshot.data!.docs[index];
                            String lvUid = dsData['uid'];
                            String lvFirstName = dsData['firstName'];
                            String lvLastName = dsData['lastName'];
                            String lvEmail = dsData['email'];
                            num lvPhone = dsData['phone'];
                            _jumlah = snapshot.data!.docs.length;
                            return ListTile(
                              onTap: () {
                                final dtBaru = UserModel(
                                    uid: lvUid,
                                    firstName: lvFirstName,
                                    lastName: lvLastName,
                                    email: lvEmail,
                                    phone: lvPhone);
                                Database.ubahData(ubahUser: dtBaru);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditData(userModel: dtBaru)));
                              },
                              title: Text(lvFirstName),
                              subtitle: Text(lvEmail),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    // Press this button to edit a single product
                                    IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewData(
                                                      userModel: UserModel(
                                                          uid: lvUid,
                                                          email: lvEmail,
                                                          firstName: lvFirstName,
                                                          lastName: lvLastName,
                                                          phone: lvPhone),
                                                    )))),
                                    // This icon button is used to delete a single product
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          Database.hapusData(hapusUser: lvUid),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8.0),
                          itemCount: snapshot.data!.docs.length);
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.yellow,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
