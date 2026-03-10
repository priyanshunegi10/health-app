import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/doctors/widgets/horizontal_date_selector.dart';
import 'package:final_year_project/services/database/data_bases_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedSelectedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Schedule",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 5, bottom: 20),
              child: Text(
                "Select a date to view appointments",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),

            Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: HorizontalDateSelector(
                    onDateSelected: (DateTime newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                )
                .animate(delay: 100.ms)
                .slideX(
                  begin: -1,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.fastOutSlowIn,
                )
                .fade(),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Available Doctors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Doctors')
                    .where(
                      'availableDates',
                      arrayContains: formattedSelectedDate,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 50,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "No doctors available on ${DateFormat('dd MMM').format(_selectedDate)}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doctorData =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
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
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                "assets/icons/doctor.png",
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctorData['name'] ?? "Unknown",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctorData['specialty'] ?? "Specialty",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${doctorData['rating'] ?? '0.0'} ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "(${doctorData['reviews'] ?? '0'} reviews)",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    doctorData['time'] ?? "--:--",
                                    style: const TextStyle(
                                      color: Color(0xFF2E8B90),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // 1. Pop-up dikhane ka function call karo
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        TextEditingController
                                        illnessController =
                                            TextEditingController();
                                        bool isBooking = false;

                                        return StatefulBuilder(
                                          // StatefulBuilder taaki pop-up ke andar loading dikha sakein
                                          builder: (context, setStateDialog) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title: Text(
                                                "Book ${doctorData['name']}",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Time: ${doctorData['time']} | Date: ${DateFormat('dd MMM').format(_selectedDate)}",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  TextField(
                                                    controller:
                                                        illnessController,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "What is your problem? (e.g. Fever)",
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              15,
                                                            ),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey.shade100,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                isBooking
                                                    ? const CircularProgressIndicator()
                                                    : ElevatedButton(
                                                        style:
                                                            ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                    0xFF2E8B90,
                                                                  ),
                                                            ),
                                                        onPressed: () async {
                                                          if (illnessController
                                                              .text
                                                              .trim()
                                                              .isEmpty) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                  "Please enter your illness",
                                                                ),
                                                              ),
                                                            );
                                                            return;
                                                          }

                                                          setStateDialog(
                                                            () => isBooking =
                                                                true,
                                                          );

                                                          try {
                                                            // Date ko Home Page card ke format ("12\ntue") mein convert karna
                                                            String
                                                            formattedCardDate =
                                                                "${DateFormat('dd').format(_selectedDate)}\n${DateFormat('E').format(_selectedDate).toLowerCase()}";

                                                            // DB mein save karna (Apna DataBasesServices import zarur karna)
                                                            await DataBasesServices().bookAppointment(
                                                              userId: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              doctorName:
                                                                  doctorData['name'],
                                                              date:
                                                                  formattedCardDate,
                                                              time:
                                                                  doctorData['time'],
                                                              illness:
                                                                  illnessController
                                                                      .text
                                                                      .trim(),
                                                            );

                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                context,
                                                              ); // Dialog band karo
                                                              ScaffoldMessenger.of(
                                                                context,
                                                              ).showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                    "Appointment Booked Successfully!",
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          } catch (e) {
                                                            if (context
                                                                .mounted) {
                                                              ScaffoldMessenger.of(
                                                                context,
                                                              ).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    "Failed to book: $e",
                                                                  ),
                                                                ),
                                                              );
                                                              setStateDialog(
                                                                () =>
                                                                    isBooking =
                                                                        false,
                                                              );
                                                            }
                                                          }
                                                        },
                                                        child: const Text(
                                                          "Confirm",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFF2E8B90,
                                    ), // Teal color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: const Size(60, 30),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text(
                                    "Book",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ).animate(delay: 500.ms).slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOut).fade(),
          ],
        ),
      ),
    );
  }
}
