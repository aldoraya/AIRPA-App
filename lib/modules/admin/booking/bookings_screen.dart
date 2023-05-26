import 'edit_data.dart';
import 'view_data.dart';
import 'tambah_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penyewaan_gedung_app/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'db_services.dart';

class BookingsScreen extends StatefulWidget {
  final BookingModel? bookingModel;

  const BookingsScreen({Key? key, this.bookingModel}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
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
    if (widget.bookingModel == null) _isDisabled = true;
    User? booking = _auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Data Booking"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _jumlah++;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TambahData()));
            },
            backgroundColor: Colors.yellow,
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
                            String lvName = dsData['name'];
                            String lvEmail = dsData['email'];
                            num lvPhone = dsData['phone'];
                            DateTime lvStartDate = dsData['startDate'].toDate();
                            DateTime lvEndDate = dsData['endDate'].toDate();
                            _jumlah = snapshot.data!.docs.length;
                            return ListTile(
                              onTap: () {
                                final dtBaru = BookingModel(
                                    name: lvName,
                                    email: lvEmail,
                                    phone: lvPhone,
                                    startDate: lvStartDate,
                                    endDate: lvEndDate);
                                Database.ubahData(ubahBooking: dtBaru);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditData(bookingModel: dtBaru)));
                              },
                              title: Text(lvName),
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
                                                      bookingModel:
                                                          BookingModel(
                                                              name: lvName,
                                                              email: lvEmail,
                                                              phone: lvPhone,
                                                              startDate:
                                                                  lvStartDate,
                                                              endDate:
                                                                  lvEndDate),
                                                    )))),
                                    // This icon button is used to delete a single product
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => Database.hapusData(
                                            hapusBooking: lvEmail)),
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
