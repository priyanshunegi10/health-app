import 'package:cloud_firestore/cloud_firestore.dart';

class DataBasesServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> getUserData(String uid) {
    return firestore.collection("User").doc(uid).snapshots();
  }

  Future<void> updateUserProfile({
    required String uid,
    required String age,
    required String weight,
    required String height,
    required String gender,
    required String bloodGroup,
  }) async {
    await firestore.collection("User").doc(uid).set({
      "Age": age,
      "Weight": weight,
      "Height": height,
      "Gender": gender,
      "Blood Group": bloodGroup,
      "profileCompleted": true,
    }, SetOptions(merge: true));
  }

  // services/database/data_bases_services.dart mein add karo

  // BOOKING: Naya appointment save karne ke liye
  Future<void> bookAppointment({
    required String userId,
    required String doctorName,
    required String date, // UI ke liye format '14\nTue'
    required String time,
    required String illness,
  }) async {
    try {
      await firestore.collection("UserAppointments").add({
        "userId": userId,
        "doctorName": doctorName,
        "date": date,
        "time": time,
        "illness": illness,
        "createdAt": FieldValue.serverTimestamp(), // Kab book kiya uska record
      });
    } catch (e) {
      print("Booking Error: $e");
      rethrow; // Error UI tak bhejne ke liye
    }
  }
}
