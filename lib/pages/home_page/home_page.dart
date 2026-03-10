import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/care_plan/care_plan_page.dart';
import 'package:final_year_project/pages/doctors/doctors_page.dart';
import 'package:final_year_project/pages/home_page/widgets/appointenment_card.dart';
import 'package:final_year_project/pages/home_page/widgets/services_card.dart';
import 'package:final_year_project/pages/profile_page/profile_page.dart';
import 'package:final_year_project/services/database/data_bases_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataBasesServices _dataBasesServices = DataBasesServices();
  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    String name = "";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: uid == null
              ? const Center(child: Text("Login Required"))
              : StreamBuilder<DocumentSnapshot>(
                  stream: _dataBasesServices.getUserData(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData && snapshot.data!.exists) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      name = data["Name"];
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    child: Image.asset(
                                      "assets/icons/greeting.png",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello!",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfilePage(),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        "assets/icons/user.png",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              .animate()
                              .fade(duration: 1000.ms)
                              .slideY(begin: -1, end: 0, curve: Curves.easeOut),
                          SizedBox(height: 25),
                          TextField(
                                decoration: InputDecoration(
                                  hintText: "Search Medical Services",
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                              .animate(
                                delay: 300.ms,
                              ) // Wait 200ms before starting
                              .fade(duration: 600.ms),

                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Services",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ).animate(delay: 500.ms).fade(duration: 1000.ms),
                            ],
                          ),

                          SizedBox(height: 10),
                          Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ServicesCard(
                                    ontap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorsPage(),
                                        ),
                                      );
                                    },
                                    height: 90,
                                    width: 80,
                                    color: Colors.purple.shade100,
                                    imagePath: "assets/icons/doctor.png",
                                  ),
                                  ServicesCard(
                                    height: 90,
                                    width: 80,
                                    color: Colors.orange.shade100,
                                    imagePath: "assets/icons/medicine.png",
                                  ),
                                  ServicesCard(
                                    ontap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarePlanPage(),
                                        ),
                                      );
                                    },
                                    height: 90,
                                    width: 80,
                                    color: Colors.blue.shade100,
                                    imagePath:
                                        "assets/icons/medical-report.png",
                                  ),
                                  ServicesCard(
                                    height: 90,
                                    width: 80,
                                    color: Colors.red.shade100,
                                    imagePath: "assets/icons/virus.png",
                                  ),
                                ],
                              )
                              .animate(delay: 400.ms)
                              .slideX(
                                begin: -1,
                                end: 0,
                                duration: 600.ms,
                                curve: Curves.fastOutSlowIn,
                              )
                              .fade(),
                          Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: Image.asset(
                                    "assets/images/health_2.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              .animate(delay: 600.ms)
                              .slideX(
                                begin: 1,
                                end: 0,
                                duration: 600.ms,
                                curve: Curves.fastOutSlowIn,
                              )
                              .fade(),

                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Upcoming Appointments",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ).animate(delay: 800.ms).fade(duration: 1000.ms),
                            ],
                          ),
                          SizedBox(height: 20),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('UserAppointments')
                                .where(
                                  'userId',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid,
                                )
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.blue.shade100,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.event_busy,
                                            size: 50,
                                            color: Colors.blueGrey,
                                          ),
                                          const SizedBox(height: 15),
                                          const Text(
                                            "No upcoming appointments",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            "Book a doctor to track your health.",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          ElevatedButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Go to Doctors tab to book!",
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xff22BED5,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: const Text(
                                              "Book Now",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .animate()
                                    .fade(duration: 800.ms)
                                    .slideY(begin: 1, end: 0);
                              }

                              List<Color> outerColors = [
                                Color(0xff22BED5),
                                Color(0xff003e4f),
                                Color(0xff009685),
                                Color(0xff6873DF),
                              ];
                              List<Color> innerColors = [
                                Color(0xff0294AD),
                                Color(0xff144D62),
                                Color(0xff74B3B6),
                                Color(0xff484BAD),
                              ];

                              return SizedBox(
                                height: 160,
                                child:
                                    ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            var bookingData =
                                                snapshot.data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>;

                                            int colorIndex =
                                                index % outerColors.length;

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15,
                                              ),
                                              child: AppointenmentCard(
                                                outercontaniner:
                                                    outerColors[colorIndex],
                                                innercontaniner:
                                                    innerColors[colorIndex],
                                                date:
                                                    bookingData['date'] ??
                                                    'N/A',
                                                time:
                                                    bookingData['time'] ??
                                                    '--:--',
                                                drName:
                                                    bookingData['doctorName'] ??
                                                    'Unknown Doctor',
                                                illness:
                                                    bookingData['illness'] ??
                                                    'General Checkup',
                                              ),
                                            );
                                          },
                                        )
                                        .animate(delay: 900.ms)
                                        .slideY(
                                          begin: 1,
                                          end: 0,
                                          duration: 600.ms,
                                        )
                                        .fade(),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
