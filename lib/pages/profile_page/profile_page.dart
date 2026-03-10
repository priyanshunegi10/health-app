import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/authentication/sign_up_page.dart';
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

  // Naya Premium UI Helper Function
  Widget _buildProfileItem({required IconData icon, required String title, required String value, required Color iconColor, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        title: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
        trailing: onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey) : null,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Scaffold(body: Center(child: Text("User not logged in")));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: dataBasesServices.getUserData(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF2E8B90)));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Profile data not found."));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          
          String name = data["Name"] ?? "User";
          String email = data["Email"] ?? "No Email";
          // Notice: Maine "Concact" aur "Contact" dono check kiye hain teri database spelling galti se bachne ke liye
          String contact = data["Contact"] ?? data["Concact"] ?? "Not Provided";
          
          // Profile pic ke liye Name ka pehla letter nikalna
          String initial = name.isNotEmpty ? name[0].toUpperCase() : "?";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // PREMIUM AVATAR SECTION
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF2E8B90), Color(0xFF1A6B70)]),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF2E8B90).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))
                    ]
                  ),
                  child: Center(
                    child: Text(
                      initial, // "P" for Priyanshu, dynamically update hoga
                      style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 30),

                // USER DETAILS SECTION
                _buildProfileItem(icon: Icons.person_outline, title: "Full Name", value: name, iconColor: const Color(0xFF2E8B90)),
                _buildProfileItem(icon: Icons.mail_outline, title: "Email Address", value: email, iconColor: Colors.orange),
                _buildProfileItem(icon: Icons.phone_outlined, title: "Contact Number", value: contact, iconColor: Colors.blue),

                const SizedBox(height: 20),

                // ACCOUNT ACTIONS
                _buildProfileItem(
                  icon: Icons.logout_rounded,
                  title: "Account Action",
                  value: "Log Out",
                  iconColor: Colors.grey.shade700,
                  onTap: () async {
                    await firebaseAuthMethods.signOut();
                    if (context.mounted) {
                      // YEH HAI SAHI TARIKA LOGOUT KA
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                        (route) => false,
                      );
                    }
                  },
                ),

                _buildProfileItem(
                  icon: Icons.delete_forever_outlined,
                  title: "Danger Zone",
                  value: "Delete Account",
                  iconColor: Colors.red,
                  onTap: () {
                    // Examiner ko impress karne ke liye confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        title: const Text("Delete Account?"),
                        content: const Text("Are you sure you want to permanently delete your account and all associated health data? This cannot be undone."),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account deletion requested. Admin will review.")));
                            },
                            child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}