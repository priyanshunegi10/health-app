import 'package:flutter/material.dart';

class SleepCard extends StatelessWidget {
  final Color containerColor;
  final String imagePath;
  final String containerName;
  final String date;
  final String text;
  final String hours;
  final String hoursText;
  final String min;
  final String minText;
  final String secondImagePath;
  const SleepCard({
    super.key,
    required this.imagePath,
    required this.containerName,
    required this.text,
    required this.hours,
    required this.hoursText,
    required this.min,
    required this.minText,
    required this.secondImagePath,
    required this.date, required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(imagePath, height: 40),
              SizedBox(width: 8),
              Text(containerName, style: TextStyle(fontSize: 20)),
              Spacer(),
              Text(date, style: TextStyle(fontSize: 18)),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(text, style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Text(
                    hours,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 2),
                  Text(hoursText),
                  SizedBox(width: 2),
                  Text(
                    min,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 2),
                  Text(minText),
                  Spacer(),
                  Image.asset(secondImagePath, height: 50),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StepsCard extends StatelessWidget {
  final Color containerColor;
  final String imagePath;
  final String containerName;
  final String noSteps;
  final String steps;
  const StepsCard({
    super.key,
    required this.imagePath,
    required this.containerName,
    required this.noSteps,
    required this.steps, required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/icons/footstep.png", height: 40),
              SizedBox(width: 8),
              Text("Steps", style: TextStyle(fontSize: 20)),
              Spacer(),
              Text("yestresday", style: TextStyle(fontSize: 18)),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "283",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 2),
              Text("steps"),

              Spacer(),
              Image.asset("assets/icons/statistics.png", height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
