import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/profile_page/widget/details_container.dart';
import 'package:final_year_project/services/autentication/firebase_auth_methods.dart';
import 'package:final_year_project/services/database/data_bases_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DataBasesServices dataBasesServices = DataBasesServices();
  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();
  String name = "";
  String email = "";
  String contact = "";
  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: dataBasesServices.getUserData(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.exists) {
            var data = snapshot.data!.data() as Map<String, dynamic>;

            name = data["Name"];
            email = data["Email"];
            contact = data["Concact"] ?? "9899784133";
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue.shade100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_rounded),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 4),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),

                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "P",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        DetailsContainer(
                          icon: Icons.person,
                          value: name,
                          title: "Name",
                        ),
                        DetailsContainer(
                          icon: Icons.mail,
                          value: email,
                          title: "Email",
                        ),
                        DetailsContainer(
                          icon: Icons.contact_emergency,
                          value: contact,
                          title: "Contact Us",
                        ),
                        DetailsContainer(
                          ontap: () {
                            firebaseAuthMethods.signOut();
                          },
                          icon: Icons.logout,
                          value: "Logout",
                          title: "Logout",
                        ),
                        DetailsContainer(
                          ontap: () {},
                          icon: Icons.delete,
                          value: "Delete Account",
                          title: "Delete Account",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
