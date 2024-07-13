import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FireStorage extends GetxService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createString(dynamic data) async {
    if (data == null) return;

    String dataName = 'uploads/${DateTime.now()}';

    try {
      await _firestore.collection("col1").doc("colDoc").collection("col2").doc("col2Doc").set({
        "message" : data
      });
      print('String create');
    } catch (e) {
      print('create Error: $e');
    }
  }
}