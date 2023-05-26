import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/modules/login/login_screen.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/bottom_tab_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const BottomTabScreen();
          }
          // user is NOT logged in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
