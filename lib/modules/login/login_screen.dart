import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/login/google_button_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/widgets/common_text_field_view.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:penyewaan_gedung_app/utils/validator.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'google_sign_in_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _obscureText = true;

  // string for displaying the error Message
  String? errorMessage;

  // editing Controller
  String _errorEmail = '';
  final TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  final TextEditingController _passwordController = TextEditingController();
  int toastDurationInMilliSeconds = 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: GoogleButtonView(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BottomTabScreen())
                        );
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Locs.alized.log_with_mail,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        )),
                    CommonTextFieldView(
                      controller: _emailController,
                      errorText: _errorEmail,
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Locs.alized.mail_text,
                      hintText: Locs.alized.enter_your_email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      controller: _passwordController,
                      errorText: _errorPassword,
                      onSaved: (value) {
                        _passwordController.text = value!;
                      },
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Locs.alized.password,
                      hintText: Locs.alized.enter_password,
                      isObsecureText: true,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(
                        labelText: 'Kata Sandi',
                      ),
                    ),
                    _forgotYourPasswordUI(),
                    CommonButton(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 8),
                        buttonText: Locs.alized.login,
                        onTap: () {
                          if (_allValidation()) {
                            signUserIn();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText: Locs.alized.login,
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _forgotYourPasswordUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: () {
                NavigationServices(context).gotoForgotPassword();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Locs.alized.forgot_your_password,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> signUserIn() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((uid) => {
                Fluttertoast.showToast(
                    msg: "Login Berhasil",
                    gravity: ToastGravity.TOP_RIGHT,
                    backgroundColor: AppTheme.primaryColor,
                    timeInSecForIosWeb: 5),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const BottomTabScreen())),
              })
          .catchError((e) {
        ScaffoldMessenger.of(e).showSnackBar(SnackBar(
          content: Text(e.message),
          duration: const Duration(seconds: 2),
          backgroundColor: AppTheme.redErrorColor,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'pengguna tidak ditemukan') {
        debugPrint('tidak ditemukan email tersebut.');
      } else if (e.code == 'kata sandi salah') {
        debugPrint('kata sandi salah untuk pengguna tersebut.');
      }
    }
  }

  bool _allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail = Locs.alized.email_cannot_empty;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = Locs.alized.enter_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = Locs.alized.password_cannot_empty;
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      _errorPassword = Locs.alized.valid_password;
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
