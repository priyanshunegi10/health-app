import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // sign up
  Future<String?> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await firestore.collection("User").doc(uid).set({
        "Id": uid,
        "Name": name,
        "Email": email,
        "Created at": DateTime.now().toIso8601String(),
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  // login

  Future<String?> logIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  // logout

  Future<void> signOut() async {
    await auth.signOut();
  }
}
