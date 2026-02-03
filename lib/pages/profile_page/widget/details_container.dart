import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String value;
  final VoidCallback? ontap;
  const DetailsContainer({
    super.key,
    required this.icon,
    this.title,
    required this.value,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: ontap,
            child: Icon(icon, size: 42, color: Colors.blue)),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
