import 'package:flutter/material.dart';

class PdfCard extends StatelessWidget {
  final Color outerContainer;
  final String imagePath;
  final Color imageColor;
  final String reportName;
  final String no;

  const PdfCard({
    super.key,
    required this.outerContainer,
    required this.imagePath,
    required this.imageColor,
    required this.reportName,
    required this.no,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(20),
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: outerContainer,
            ),
            child: Image.asset(imagePath, color: imageColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reportName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(no, style: TextStyle()),
            ],
          ),
          Spacer(),
          Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
