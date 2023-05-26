import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/utils/validator.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/widgets/common_text_field_view.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _errorEmail = '';
  String _emailController = '';
  bool showLoading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 16, left: 24, right: 24),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              Locs.alized.resend_email_link,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonTextFieldView(
                      errorText: _errorEmail,
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Locs.alized.mail_text,
                      hintText: Locs.alized.enter_your_email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _emailController = value;
                        });
                      },
                    ),
                    CommonButton(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 8),
                        buttonText: Locs.alized.send,
                        onTap: () {
                          if (_allValidation()) {
                            _emailController.isEmpty
                                ? null
                                : () async {
                                    showLoading = true;
                                    sendVerificationEmail(_emailController)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Email terkirim'),
                                        backgroundColor:
                                            Color.fromARGB(255, 237, 237, 63),
                                      ));
                                    });
                                  };
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
      titleText: Locs.alized.forgot_your_password,
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  Future<void> sendVerificationEmail(emailAddress) async {
    try {
      await auth.sendPasswordResetEmail(email: emailAddress);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 5),
        backgroundColor: AppTheme.redErrorColor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ));
    }
  }

  bool _allValidation() {
    bool isValid = true;

    if (_emailController.trim().isEmpty) {
      _errorEmail = Locs.alized.email_cannot_empty;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.trim())) {
      _errorEmail = Locs.alized.enter_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    setState(() {});
    return isValid;
  }
}
