import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import '../../models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penyewaan_gedung_app/models/booking_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:penyewaan_gedung_app/widgets/common_text_field_view.dart';
import 'package:penyewaan_gedung_app/utils/validator.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_app/widgets/button_date_range.dart';
import 'package:penyewaan_gedung_app/modules/admin/booking/db_services.dart';

class BookingScreen extends StatefulWidget {
  final GedungListData gedungData;
  final BookingModel? bookingModel;

  const BookingScreen({Key? key, required this.gedungData, this.bookingModel})
      : super(key: key);

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  bool isInList = false;

  String _errorName = '';
  final TextEditingController _nameController = TextEditingController();
  String _errorEmail = '';
  final TextEditingController _emailController = TextEditingController();
  String _errorPhone = '';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTimeRange? dateRange;
  int _jumlah = 0;

  String getFrom() {
    if (dateRange == null) {
      return 'Dari';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Sampai';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(Locs.alized.booking_form),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppTheme.primaryTextColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Locs.alized.booking_form,
                  style: TextStyles(context).getBoldStyle().copyWith(
                        fontSize: 22,
                        color: AppTheme.primaryTextColor,
                      ),
                ),
                Text(
                  widget.gedungData.titleTxt,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getBoldStyle().copyWith(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                ),
                CommonTextFieldView(
                  controller: _nameController,
                  errorText: _errorName,
                  onSaved: (value) {
                    _nameController.text = value!;
                  },
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  titleText: 'Nama',
                  hintText: 'Masukan nama anda',
                  keyboardType: TextInputType.name,
                  onChanged: (String txt) {},
                ),
                const SizedBox(height: 16),
                CommonTextFieldView(
                  controller: _emailController,
                  errorText: _errorEmail,
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  titleText: Locs.alized.mail_text,
                  hintText: Locs.alized.enter_your_email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String txt) {},
                ),
                const SizedBox(height: 16),
                CommonTextFieldView(
                  controller: _phoneController,
                  errorText: _errorPhone,
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  titleText: 'No Telpon',
                  hintText: 'Masukan No telpon Anda',
                  keyboardType: TextInputType.phone,
                  onChanged: (String txt) {},
                  maxLength: 13,
                ),
                const SizedBox(height: 16),
                const Text('Pilih Tanggal'),
                Row(
                  children: [ 
                    Expanded(
                      child: ButtonWidget(
                        text: getFrom(),
                        onClicked: () => pickDateRange(context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ButtonWidget(
                        text: getUntil(),
                        onClicked: () => pickDateRange(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                CommonButton(
                  buttonText: 'Kirim',
                  onTap: () {
                    if (_allValidation()) {
                      _submitForm();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm({GedungListData? gedungData}) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(Locs.alized.booking_confirmation),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '\n\nTerima kasih telah memesan, ${_nameController.text}!\n\n'
                  'Rincian pemesanan:\n\n'
                  'Email:\n ${_emailController.text}\n\n'
                  'Catatan:\n ${_noteController.text}\n\n'
                  'Tanggal Pemesanan:\n $dateRange\n\n'
                ),
              ],
            ),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: [
            CommonButton(
              buttonText: 'Ok',
              onTap: () {
                _jumlah++;
                final dt = BookingModel(
                    name: _nameController.text,
                    email: _emailController.text,
                    phone: num.parse(_phoneController.text),
                    startDate: dateRange!.start,
                    endDate: dateRange!.end);
                Database.tambahData(tambahBooking: dt);
                Fluttertoast.showToast(
                    msg: "Pesanan anda sudah terkirim!",
                    gravity: ToastGravity.TOP_RIGHT,
                    backgroundColor: AppTheme.primaryColor,
                    timeInSecForIosWeb: 5);
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => const BottomTabScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      );
    }
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 7)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  bool _allValidation() {
    bool isValid = true;

    if (_nameController.text.trim().isEmpty) {
      _errorName = 'Nama tidak boleh kosong';
      isValid = false;
    } else {
      _errorName = '';
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

    if (_phoneController.text.trim().isEmpty) {
      _errorPhone = 'No hp tidak boleh kosong';
      isValid = false;
    } else {
      _errorPhone = '';
    }

    setState(() {});
    return isValid;
  }
}
