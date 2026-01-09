import 'package:final_year_project/pages/doctors/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child:
                Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Schedule",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        DoctorCard(
                          containerColor: Colors.amber,
                          imagePath: "assets/images/doctor_1.png",
                          doctorName: "Dr. Nitin jain",
                          expec: "5 years of experience",
                          rating: "4.5",
                          noPeople: "5000 people",
                          specialization: "Genral physician",
                        ),
                        DoctorCard(
                          containerColor: Colors.amber,
                          imagePath: "assets/images/doctor_1.png",
                          doctorName: "Dr. Nitin jain",
                          expec: "5 years of experience",
                          rating: "4.5",
                          noPeople: "5000 people",
                          specialization: "Genral physician",
                        ),
                        DoctorCard(
                          containerColor: Colors.amber,
                          imagePath: "assets/images/doctor_1.png",
                          doctorName: "Dr. Nitin jain",
                          expec: "5 years of experience",
                          rating: "4.5",
                          noPeople: "5000 people",
                          specialization: "Genral physician",
                        ),
                      ],
                    )
                    .animate(delay: 400.ms)
                    .slideY(
                      begin: 1,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ) // From Bottom
                    .fade(),
          ),
        ),
      ),
    );
  }
}
