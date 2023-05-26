import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/gedung_model.dart';

class ViewData extends StatefulWidget {
  final GedungModel gedungModel;

  const ViewData({Key? key, required this.gedungModel}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lihat Gedung"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Text("Nama Gedung"),
            subtitle: Text(widget.gedungModel.titleTxt!),
            leading: const Icon(Icons.apartment),
          ),
          ListTile(
            title: const Text("Kota"),
            subtitle: Text(widget.gedungModel.subTxt!),
            leading: const Icon(Icons.location_city),
          ),
          ListTile(
            title: const Text("Deskripsi Pendek"),
            subtitle: Text(widget.gedungModel.desc1!),
            leading: const Icon(Icons.note),
          ),
          const SizedBox(
            height: 15.0,
          ),
          ListTile(
            title: const Text("Deskripsi Panjang"),
            subtitle: Text(widget.gedungModel.desc2!),
            leading: const Icon(Icons.note_alt_outlined),
          ),
          ListTile(
            title: const Text("Harga"),
            subtitle: Text(widget.gedungModel.perDay.toString()),
            leading: const Icon(Icons.money),
          ),
          ListTile(
            title: const Text("Detail Lokasi"),
            subtitle: Text(widget.gedungModel.location!),
            leading: const Icon(Icons.location_on),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
