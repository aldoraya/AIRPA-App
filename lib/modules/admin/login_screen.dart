import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/admin/admin_screen.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/widgets/common_text_field_view.dart';
import 'package:penyewaan_gedung_app/widgets/remove_focuse.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  // string for displaying the error Message
  String? errorMessage;
  bool _obscureText = true;

  // editing Controller
  String _errorUName = '';
  final TextEditingController _uNameController = TextEditingController();
  String _errorPassword = '';
  final TextEditingController _passwordController = TextEditingController();
  String uname = "adminjos";
  String pass = "admin999";
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
                    const Padding(padding: EdgeInsets.all(16.0)),
                    CommonTextFieldView(
                      controller: _uNameController,
                      errorText: _errorUName,
                      onSaved: (value) {
                        _uNameController.text = value!;
                      },
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: 'Username',
                      hintText: 'Masukan username anda',
                      keyboardType: TextInputType.name,
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
                      isObsecureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      ),
                    ),
                    CommonButton(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 8),
                        buttonText: Locs.alized.login,
                        onTap: () {
                          if (_allValidation()) {
                            loginAdmin();
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

  Future<void> loginAdmin() async {
    if (uname == _uNameController.text && pass == _passwordController.text) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdminScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Username tau password tidak ditemukan'),
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
      _uNameController.text = "";
      _passwordController.text = "";
    }
  }

  bool _allValidation() {
    bool isValid = true;
    if (_uNameController.text.trim().isEmpty) {
      _errorUName = 'Username tidak boleh kosong';
      isValid = false;
    } else {
      _errorUName = '';
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
