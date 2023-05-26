import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/modules/splash/splash_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Halaman Admin"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                signOut();
              },
            ),
          ]),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            height: 60,
            child: ListTile(
                onTap: () async {
                  NavigationServices(context).gotoUsersScreen();
                },
                title: const Text('User'),
                leading: const Icon(Icons.people)),
          ),
          SizedBox(
            height: 60,
            child: ListTile(
                onTap: () async {
                  NavigationServices(context).gotoGedungScreen();
                },
                title: const Text("Gedung"),
                leading: const Icon(Icons.apartment)),
          ),
          SizedBox(
            height: 60,
            child: ListTile(
                onTap: () async {
                  NavigationServices(context).gotoBookingsScreen();
                },
                title: const Text("Booking"),
                leading: const Icon(Icons.shop)),
          )
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SplashScreen()),
            (route) => false));
  }
}
