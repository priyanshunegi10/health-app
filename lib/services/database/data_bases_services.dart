import 'package:cloud_firestore/cloud_firestore.dart';

class DataBasesServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getUserData(String uid) {
    return firestore.collection("User").doc(uid).snapshots();
  }
}
