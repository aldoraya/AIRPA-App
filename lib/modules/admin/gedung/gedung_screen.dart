import 'edit_data.dart';
import 'view_data.dart';
import 'tambah_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/gedung_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

import 'db_services.dart';

class GedungScreen extends StatefulWidget {
  final GedungModel? gedungModel;
  const GedungScreen({Key? key, this.gedungModel}) : super(key: key);

  @override
  State<GedungScreen> createState() => _GedungScreenState();
}

class _GedungScreenState extends State<GedungScreen> {
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
    if (widget.gedungModel == null) _isDisabled = true;
    User? gedung = _auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Data Gedung"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _jumlah++;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TambahData()));
            },
            backgroundColor: AppTheme.primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            )),
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
                            String lvTitleTxt = dsData['titleTxt'];
                            String lvSubTxt = dsData['subTxt'];
                            String lvDesc1 = dsData['desc1'];
                            String lvDesc2 = dsData['desc2'];
                            num lvPerDay = dsData['perDay'];
                            String lvLocation = dsData['location'];
                            _jumlah = snapshot.data!.docs.length;
                            return ListTile(
                              onTap: () {
                                final dtBaru = GedungModel(
                                    titleTxt: lvTitleTxt,
                                    subTxt: lvSubTxt,
                                    desc1: lvDesc1,
                                    desc2: lvDesc2,
                                    perDay: lvPerDay,
                                    location: lvLocation);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditData(gedungModel: dtBaru)));
                              },
                              title: Text(lvTitleTxt),
                              subtitle: Text(lvPerDay.toString()),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    // Press this button to edit a single product
                                    IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        onPressed: () => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewData(
                                                            gedungModel: GedungModel(
                                                                titleTxt:
                                                                    lvTitleTxt,
                                                                subTxt:
                                                                    lvSubTxt,
                                                                desc1: lvDesc1,
                                                                desc2: lvDesc2,
                                                                perDay:
                                                                    lvPerDay,
                                                                location:
                                                                    lvLocation),
                                                          ))),
                                            }),
                                    // This icon button is used to delete a single product
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => Database.hapusData(
                                            hapusGedung: lvTitleTxt)),
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
