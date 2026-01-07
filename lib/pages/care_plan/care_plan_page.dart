import 'package:final_year_project/pages/care_plan/widgets/my_cards.dart';
import 'package:final_year_project/pages/care_plan/widgets/pdf.dart';
import 'package:flutter/material.dart';

class CarePlanPage extends StatelessWidget {
  const CarePlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 25, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Report",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Icon(Icons.more_horiz, size: 30),
                  ],
                ),
                SizedBox(height: 30),
                HeartRateCard(),
                SizedBox(height: 20),
                Row(
                  children: [
                    MyCards(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4 + 10,
                      color: Colors.red.shade100,
                      imagePath: "assets/icons/blood_drop.png",
                      bloodGroup: "Blood Group",
                      blood: "A+",
                    ),
                    SizedBox(width: 10),
                    MyCards(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4 + 10,
                      color: Colors.green.shade100,
                      imagePath: "assets/icons/scale.png",
                      bloodGroup: "weight",
                      blood: "80",
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Lattest Report",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Pdf(
                      outerContainer: Colors.blue.shade100,
                      imagePath: "assets/icons/dark_page.png",
                      imageColor: Colors.blue.shade600,
                      reportName: "Genral health",
                      no: "8 files",
                    ),
                    Pdf(
                      outerContainer: Colors.blue.shade100,
                      imagePath: "assets/icons/dark_page.png",
                      imageColor: Colors.blue.shade600,
                      reportName: "Genral health",
                      no: "8 files",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
