import 'package:flutter/material.dart';

class MyCards extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String imagePath;
  final String bloodGroup;
  final String blood;
  const MyCards({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.imagePath,
    required this.bloodGroup,
    required this.blood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(imagePath, height: 50, width: 50),
              Icon(Icons.more_horiz),
            ],
          ),
          SizedBox(height: 8),
          Text(bloodGroup, style: TextStyle(fontSize: 14)),
          Text(
            blood,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class HeartRateCard extends StatelessWidget {
  const HeartRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Heart Rate",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "96",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
