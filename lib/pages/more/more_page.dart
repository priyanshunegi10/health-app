import 'package:final_year_project/pages/more/health_alert_page.dart';
import 'package:final_year_project/pages/more/my_reports_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Current user ka data
    final user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? "User";

    return Scaffold(
      backgroundColor: Colors
          .grey
          .shade50, // Thoda off-white taaki white cards pop out karein
      appBar: AppBar(
        title: const Text(
          "More Features",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // USER PROFILE HEADER
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 25, top: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E8B90), Color(0xFF1A6B70)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF2E8B90),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Health Profile",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FEATURES LIST (Scrollable)
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // 1. My Reports (Jo local hack wala feature tha)
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.folder_copy_outlined,
                    iconColor: Colors.blue,
                    title: "My Medical Reports",
                    subtitle: "View and upload your local PDFs",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyReportsPage(),
                        ),
                      );
                    },
                  ),

                  // 2. Health Alerts (Outbreak news)
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.campaign_outlined,
                    iconColor: Colors.orange,
                    title: "Health Alerts & News",
                    subtitle: "Latest outbreaks and medical updates",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthAlertsPage(),
                        ),
                      );
                    },
                  ),

                  // 3. Emergency
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.emergency_outlined,
                    iconColor: Colors.red,
                    title: "Emergency Services",
                    subtitle: "Quick dial ambulance (108)",
                    onTap: () async {
                      final Uri emergencyDialUri = Uri(
                        scheme: 'tel',
                        path: '108',
                      );

                      try {
                        if (await canLaunchUrl(emergencyDialUri)) {
                          await launchUrl(emergencyDialUri);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Error: Cannot open phone dialer on this device.",
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        print("Call Action Error: $e");
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  // 4. LOGOUT BUTTON
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.logout_rounded,
                    iconColor: Colors.grey.shade800,
                    title: "Log Out",
                    subtitle: "Securely sign out of your account",
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.of(
                            context,
                          ).pushNamedAndRemoveUntil('/login', (route) => false);
                        }
                      } catch (e) {
                        print("Logout Error: $e");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
