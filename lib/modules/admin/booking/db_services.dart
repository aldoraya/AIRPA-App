import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/booking_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

CollectionReference bookingModel = FirebaseFirestore.instance.collection("booking");

class Database {
  static Stream<QuerySnapshot> getData(String gid) {
    if (gid == "") {
      return bookingModel.snapshots();
    } else {
      return bookingModel
          // .where("gidCat",isEqualTo: gid)
          .orderBy("gid")
          .startAt([gid]).endAt([gid + '\uf8ff']).snapshots();
    }
  }

  static Future<void> tambahData({required BookingModel tambahBooking}) async {
     DocumentReference docRef = bookingModel.doc(tambahBooking.email);
     
     await docRef
        .set(tambahBooking.toJson())
        .whenComplete(() => {
              Fluttertoast.showToast(
                  msg: "Data berhasil ditambah!",
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

  static Future<void> ubahData({required BookingModel ubahBooking}) async {
    DocumentReference docRef = bookingModel.doc(ubahBooking.email);

    await docRef
        .update(ubahBooking.toJson())
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

  static Future<void> hapusData({required String hapusBooking}) async {
    DocumentReference docRef = bookingModel.doc(hapusBooking);

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
