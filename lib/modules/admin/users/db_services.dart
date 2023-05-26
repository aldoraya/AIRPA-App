import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

CollectionReference userModel = FirebaseFirestore.instance.collection("users");

class Database {
  static Stream<QuerySnapshot> getData(String uid) {
    if (uid == "") {
      return userModel.snapshots();
    } else {
      return userModel
          // .where("uidCat",isEqualTo: uid)
          .orderBy("uid")
          .startAt([uid]).endAt([uid + '\uf8ff']).snapshots();
    }
  }

  static Future<void> tambahData({required UserModel tambahUser}) async {
  DocumentReference docRef = userModel.doc(tambahUser.uid);

     await docRef
        .set(tambahUser.toJson())
        .whenComplete(() => {
              Fluttertoast.showToast(
                  msg: "Data berhasil dibuat!",
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

  static Future<void> ubahData({required UserModel ubahUser}) async {
    DocumentReference docRef = userModel.doc(ubahUser.uid);

    await 
    docRef
        .update(ubahUser.toJson())
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

  static Future<void> hapusData({required String hapusUser}) async {
    DocumentReference docRef = userModel.doc(hapusUser);

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
