import 'package:penyewaan_gedung_app/models/booking_model.dart';
import 'db_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_app/widgets/button_date_range.dart';

class EditData extends StatefulWidget {
  final BookingModel? bookingModel;

  const EditData({Key? key, this.bookingModel}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'Dari';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Sampai';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.end);
    }
  }

  bool _isDisabled = false;

  final _auth = FirebaseAuth.instance;
  int _jumlah = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.bookingModel?.name ?? "";
    _emailController.text = widget.bookingModel?.email ?? "";
    _phoneController.text = widget.bookingModel?.phone.toString() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bookingModel == null) _isDisabled = true;
    User? booking = _auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Ubah Booking'),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Phone'),
              ),
              const SizedBox(
                height: 24.0,
              ),
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
              const SizedBox(
                height: 24.0,
              ),
              CommonButton(
                onTap: () {
                  _jumlah++;
                  final dt = BookingModel(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.hashCode,
                      startDate: dateRange!.start,
                      endDate: dateRange!.end);
                  Database.ubahData(ubahBooking: dt);
                  Navigator.pop(context);
                },
                buttonText: 'Ubah Data',
              ),
            ],
          ),
        ));
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
}
