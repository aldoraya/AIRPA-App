import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/booking_model.dart';
import 'package:intl/intl.dart';

class ViewData extends StatefulWidget {
  final BookingModel bookingModel;

  const ViewData({Key? key, required this.bookingModel}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lihat booking"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Text("Nama"),
            subtitle: Text(widget.bookingModel.name),
            leading: const Icon(Icons.people),
          ),
          ListTile(
            title: const Text("Email"),
            subtitle: Text(widget.bookingModel.email),
            leading: const Icon(Icons.email),
          ),
          ListTile(
            title: const Text("No Telpon"),
            subtitle: Text(widget.bookingModel.phone.toString()),
            leading: const Icon(Icons.phone),
          ),
          ListTile(
            title: const Text("Tanggal Mulai"),
            subtitle: Text(
                DateFormat('dd/MM/yyyy').format(widget.bookingModel.startDate)),
            leading: const Icon(Icons.date_range),
          ),
          ListTile(
            title: const Text("Tanggal Selesai"),
            subtitle: Text(
                DateFormat('dd/MM/yyyy').format(widget.bookingModel.endDate)),
            leading: const Icon(Icons.date_range),
          ),
        ],
      ),
    );
  }
}
