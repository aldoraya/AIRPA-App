import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/login/google_button_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/widgets/common_text_field_view.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import 'package:penyewaan_gedung_app/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  bool _obscureText = true;

  // editing Controller
  String _errorFName = '';
  final _firstNameController = TextEditingController();
  String _errorLName = '';
  final _lastNameController = TextEditingController();
  String _errorEmail = '';
  final _emailController = TextEditingController();
  String _errorPassword = '';
  final _passwordController = TextEditingController();
  String _errorConfirmPassword = '';
  final _confirmPasswordController = TextEditingController();
  bool showSpinner = false;

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
                    const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: GoogleButtonView(),
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
                      controller: _firstNameController,
                      errorText: _errorFName,
                      onSaved: (value) {
                        _firstNameController.text = value!;
                      },
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Locs.alized.first_name,
                      hintText: Locs.alized.enter_first_name,
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      controller: _lastNameController,
                      errorText: _errorLName,
                      onSaved: (value) {
                        _firstNameController.text = value!;
                      },
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: Locs.alized.last_name,
                      hintText: Locs.alized.enter_last_name,
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
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
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String txt) {},
                      isObsecureText: _obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    CommonTextFieldView(
                      controller: _confirmPasswordController,
                      errorText: _errorConfirmPassword,
                      onSaved: (value) {
                        _confirmPasswordController.text = value!;
                      },
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: 'Konfirmasi Kata Sandi',
                      hintText: Locs.alized.enter_password,
                      keyboardType: TextInputType.visiblePassword,
                      isObsecureText: _obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      onChanged: (String txt) {},
                    ),
                    CommonButton(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                      buttonText: Locs.alized.sign_up,
                      onTap: () {
                        if (_allValidation()) {
                          signUpUser();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        Locs.alized.terms_agreed,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Locs.alized.already_have_account,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          onTap: () {
                            NavigationServices(context).gotoLoginScreen();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              Locs.alized.login,
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 24,
                    )
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
      titleText: Locs.alized.sign_up,
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  Future<void> signUpUser() async {
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
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
    });
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(
        uid: user!.uid,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text);

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.firstName = _firstNameController.text;
    userModel.lastName = _lastNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Akun berhasil dibuat :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const BottomTabScreen()),
        (route) => false);
  }

  bool _allValidation() {
    bool isValid = true;

    if (_firstNameController.text.trim().isEmpty) {
      _errorFName = Locs.alized.first_name_cannot_empty;
      isValid = false;
    } else {
      _errorFName = '';
    }

    if (_lastNameController.text.trim().isEmpty) {
      _errorLName = Locs.alized.last_name_cannot_empty;
      isValid = false;
    } else {
      _errorLName = '';
    }

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

    if (_confirmPasswordController.text.trim().isEmpty) {
      _errorConfirmPassword = Locs.alized.password_cannot_empty;
      isValid = false;
    } else if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      _errorConfirmPassword = 'tidak cocok';
      isValid = false;
    } else {
      _errorConfirmPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
