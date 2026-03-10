import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String imagePath;
  final VoidCallback? ontap;

  const ServicesCard({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.imagePath,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(imagePath, height: 40, width: 40),
        ),
      ),
    );
  }
}
