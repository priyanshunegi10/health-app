import 'package:final_year_project/pages/profile_page/widget/details_container.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      value: "Priyanshu",
                      title: "Name",
                    ),
                    DetailsContainer(
                      icon: Icons.mail,
                      value: "priyanshu@example.com",
                      title: "Email",
                    ),
                    DetailsContainer(
                      icon: Icons.contact_emergency,
                      value: "9876543210",
                      title: "Contact Us",
                    ),
                    DetailsContainer(
                      icon: Icons.logout,
                      value: "Logout",
                      title: "Logout",
                    ),
                    DetailsContainer(
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
      ),
    );
  }
}
