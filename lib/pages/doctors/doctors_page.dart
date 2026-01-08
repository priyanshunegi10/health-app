import 'package:final_year_project/pages/doctors/widgets/doctor_card.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Schedule",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
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
            ),
          ),
        ),
      ),
    );
  }
}
