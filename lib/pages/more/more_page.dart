import 'package:final_year_project/pages/more/widgets/my_cards.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            children: [
              Text(
                "Summary",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              SleepCard(
                containerColor: Colors.blue.shade100,
                imagePath: "assets/icons/bed.png",
                containerName: "Sleep",
                date: "Yesterday",
                text: "Time in bed",
                hours: "4",
                hoursText: "hr",
                min: "10",
                minText: "min",
                secondImagePath: "assets/icons/statistics.png",
              ),
              StepsCard(
                containerColor: Colors.red.shade100,
                imagePath: 'assets/icons/footstep.png',
                containerName: 'Steps',
                noSteps: '2000',
                steps: 'Steps',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
