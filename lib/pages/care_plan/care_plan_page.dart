import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/care_plan/widgets/daily_health_tip_card.dart';
import 'package:final_year_project/pages/care_plan/widgets/my_cards.dart';
import 'package:final_year_project/services/database/data_bases_services.dart';
import 'package:final_year_project/services/health_calculaor.dart';
import 'package:final_year_project/utils/pdf_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CarePlanPage extends StatelessWidget {
  const CarePlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: SafeArea(
        child: uid == null
            ? const Center(child: Text("User not logged in"))
            : StreamBuilder<DocumentSnapshot>(
                stream: DataBasesServices().getUserData(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text("No health data found"));
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>;
                  String userBloodGroup = userData['Blood Group'] ?? 'N/A';
                  String userWeight = userData['Weight'] ?? '0';
                  String userHeight = userData['Height'] ?? '0';
                  String userAge = userData['Age'] ?? '0';
                  String userGender = userData['Gender'] ?? 'Other';

                  String bmi = HealthCalculator.calculateBMI(
                    userWeight,
                    userHeight,
                  );
                  String bmiStatus = HealthCalculator.getBMICategory(bmi);
                  String water = HealthCalculator.calculateWaterIntake(
                    userWeight,
                  );
                  String protein = HealthCalculator.calculateProteinIntake(
                    userWeight,
                  );
                  String calories = HealthCalculator.calculateDailyCalories(
                    userWeight,
                    userHeight,
                    userAge,
                    userGender,
                  );

                  // double cardHeight = MediaQuery.of(context).size.height * 0.2;
                  double cardWidth = MediaQuery.of(context).size.width * 0.42;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Health Report",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),

                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      size: 30,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onSelected: (String result) async {
                                      if (result == 'download') {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Generating PDF Report...",
                                            ),
                                          ),
                                        );

                                        await PdfGenerator.generateHealthReport(
                                          name: userData['Name'] ?? 'User',
                                          age: userAge,
                                          weight: userWeight,
                                          bmi: bmi,
                                          water: water,
                                          calories: calories,
                                        );
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'download',
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.download_rounded,
                                                  color: Color(0xFF2E8B90),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Download Report",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                  ),
                                ],
                              )
                              .animate()
                              .fade(duration: 1000.ms)
                              .slideY(begin: -2, end: 0, curve: Curves.easeOut),

                          const SizedBox(height: 30),

                          const DailyHealthTipCard()
                              .animate(delay: 400.ms)
                              .slideX(
                                begin: -1,
                                end: 0,
                                duration: 600.ms,
                                curve: Curves.fastOutSlowIn,
                              )
                              .fade(),

                          const SizedBox(height: 25),

                          const Text(
                                "Personal Metrics",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                              .animate()
                              .fade(duration: 1000.ms)
                              .slideY(begin: -2, end: 0, curve: Curves.easeOut),

                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyCards(
                                    width: cardWidth,
                                    color: Colors.red.shade100,
                                    imagePath: "assets/icons/blood_drop.png",
                                    bloodGroup: "Blood Group",
                                    blood: userBloodGroup,
                                  )
                                  .animate(delay: 500.ms)
                                  .slideX(begin: -1, end: 0)
                                  .fade(),

                              MyCards(
                                    width: cardWidth,
                                    color: Colors.green.shade100,
                                    imagePath: "assets/icons/scale.png",
                                    bloodGroup: "Weight",
                                    blood: "$userWeight kg",
                                  )
                                  .animate(delay: 500.ms)
                                  .slideX(begin: 1, end: 0)
                                  .fade(),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyCards(
                                    width: cardWidth,
                                    color: Colors.purple.shade100,
                                    imagePath: "assets/icons/bmi.png",
                                    bloodGroup: "BMI ($bmiStatus)",
                                    blood: bmi,
                                  )
                                  .animate(delay: 600.ms)
                                  .slideX(begin: -1, end: 0)
                                  .fade(),

                              MyCards(
                                    width: cardWidth,
                                    color: Colors.blue.shade100,
                                    imagePath: "assets/icons/water.png",
                                    bloodGroup: "Daily Water",
                                    blood: "$water L",
                                  )
                                  .animate(delay: 600.ms)
                                  .slideX(begin: 1, end: 0)
                                  .fade(),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyCards(
                                    width: cardWidth,
                                    color: Colors.orange.shade100,
                                    imagePath: "assets/icons/calories.png",
                                    bloodGroup: "Calories",
                                    blood: "$calories kcal",
                                  )
                                  .animate(delay: 700.ms)
                                  .slideX(begin: -1, end: 0)
                                  .fade(),

                              MyCards(
                                    width: cardWidth,
                                    color: Colors.yellow.shade100,
                                    imagePath: "assets/icons/protein.png",
                                    bloodGroup: "Protein",
                                    blood: "$protein g",
                                  )
                                  .animate(delay: 700.ms)
                                  .slideX(begin: 1, end: 0)
                                  .fade(),
                            ],
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
