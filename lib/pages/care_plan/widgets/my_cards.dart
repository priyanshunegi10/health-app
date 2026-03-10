import 'package:flutter/material.dart';

class MyCards extends StatelessWidget {
  final double width;
  final Color color;
  final String imagePath;
  final String bloodGroup;
  final String blood;
  const MyCards({
    super.key,
    required this.width,
    required this.color,
    required this.imagePath,
    required this.bloodGroup,
    required this.blood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      height: MediaQuery.of(context).size.height / 3.8,
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
          Flexible(
            child: Text(
              blood,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
