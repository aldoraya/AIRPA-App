import '../../../models/gedung_model.dart';
import 'db_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';

class TambahData extends StatefulWidget {
  final GedungModel? gedungModel;
  const TambahData({Key? key, this.gedungModel}) : super(key: key);

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final _titleTxtController = TextEditingController();
  final _subTxtController = TextEditingController();
  final _desc1Controller = TextEditingController();
  final _desc2Controller = TextEditingController();
  final _perDayController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isDisabled = false;

  final _auth = FirebaseAuth.instance;
  int _jumlah = 0;

  double convertPerDay(TextEditingController value1) {
    return double.parse(value1.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTxtController.dispose();
    _subTxtController.dispose();
    _desc1Controller.dispose();
    _desc2Controller.dispose();
    _perDayController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _titleTxtController.text = widget.gedungModel?.titleTxt ?? "";
    _subTxtController.text = widget.gedungModel?.subTxt ?? "";
    _desc1Controller.text = widget.gedungModel?.desc1 ?? "";
    _desc2Controller.text = widget.gedungModel?.desc2 ?? "";
    _perDayController.text = widget.gedungModel?.perDay.toString() ?? "";
    _locationController.text = widget.gedungModel?.location ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gedungModel == null) _isDisabled = true;


    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Gedung'),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleTxtController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama Gedung'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _subTxtController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Kota'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _desc1Controller,
                maxLines: 2,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Deskripsi Pendek'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _desc2Controller,
                maxLines: 5,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Deskripsi Panjang'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _perDayController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Harga'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Detail Lokasi'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              CommonButton(
                onTap: () {
                 _jumlah++;
                  final dt = GedungModel(
                      titleTxt: _titleTxtController.text,
                      subTxt: _subTxtController.text,
                      desc1: _desc1Controller.text,
                      desc2: _desc2Controller.text,
                      perDay: double.parse(_perDayController.text),
                      location: _locationController.text);
                  Database.tambahData(tambahGedung: dt);
                  Navigator.pop(context);
                },
                buttonText: 'Tambah Data',
              ),
            ],
          ),
        ));
  }
}
