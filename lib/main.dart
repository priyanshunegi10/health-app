import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/components/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:final_year_project/firebase_options.dart';
import 'package:final_year_project/pages/authentication/sign_up_page.dart';
import 'package:final_year_project/pages/user_details_page/complete_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Health care app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("User")
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  Map<String, dynamic> data =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  bool isProfileComplete = data['profileCompleted'] ?? false;

                  if (isProfileComplete) {
                    return MyBottomNavigationBar();
                  } else {
                    return const CompleteProfilePage();
                  }
                }
                return const CompleteProfilePage();
              },
            );
          }

          return const SignUpPage();
        },
      ),
    );
  }
}
