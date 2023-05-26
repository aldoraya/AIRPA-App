import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/gedung_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

CollectionReference gedungModel = FirebaseFirestore.instance.collection("gedung");

class Database {
  static Stream<QuerySnapshot> getData(String gid) {
    if (gid == "") {
      return gedungModel.snapshots();
    } else {
      return gedungModel
          // .where("gidCat",isEqualTo: gid)
          .orderBy("gid")
          .startAt([gid]).endAt([gid + '\uf8ff']).snapshots();
    }
  }

  static Future<void> tambahData({required GedungModel tambahGedung}) async {
     DocumentReference docRef = gedungModel.doc(tambahGedung.titleTxt);
     
     await docRef
        .set(tambahGedung.toJson())
        .whenComplete(() => {
              Fluttertoast.showToast(
                  msg: "Data berhasil diubah!",
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 2)
            })
        .catchError((e) {
      ScaffoldMessenger.of(e).showSnackBar(SnackBar(
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

  static Future<void> ubahData({required GedungModel ubahGedung}) async {
    DocumentReference docRef = gedungModel.doc(ubahGedung.titleTxt);

    await docRef
        .update(ubahGedung.toJson())
        .whenComplete(() => {
              Fluttertoast.showToast(
                  msg: "Data berhasil diubah!",
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 2)
            })
        .catchError((e) {
      ScaffoldMessenger.of(e).showSnackBar(SnackBar(
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

  static Future<void> hapusData({required String hapusGedung}) async {
    DocumentReference docRef = gedungModel.doc(hapusGedung);

    await docRef
        .delete()
        .whenComplete(() => {
              Fluttertoast.showToast(
                  msg: "Data berhasil dihapus!",
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 2)
            })
        .catchError((e) {
      ScaffoldMessenger.of(e).showSnackBar(SnackBar(
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
}
