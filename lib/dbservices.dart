import 'package:cloud_firestore/cloud_firestore.dart';
import 'dataclass.dart';

CollectionReference tblbook = FirebaseFirestore.instance.collection("CRUD");

class Db {
   static Stream<QuerySnapshot> getData(String nama) {
    if (nama == "") {
      return tblbook.snapshots();
    } else {
      return tblbook
      // .where("nama",isEqualTo: nama)
      .orderBy("nama")
      .startAt([nama]).endAt([nama + '\uf8ff'])
      .snapshots();
    }
  }

  static Future<void> tambahData({required booking item}) async {
    DocumentReference docRef = tblbook.doc(item.itemNama);

    await docRef
    .set(item.toJson())
    .whenComplete(() => print("data berhasil diinput"))
    .catchError((e) => print(e));
  }

}
