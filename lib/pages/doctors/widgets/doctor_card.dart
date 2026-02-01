import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final Color containerColor;
  final String imagePath;
  final String doctorName;
  final String expec;
  final String rating;
  final String noPeople;
  final String specialization;

  const DoctorCard({
    super.key,
    required this.containerColor,
    required this.imagePath,
    required this.doctorName,
    required this.expec,
    required this.rating,
    required this.noPeople,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      // height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 160,
                width: MediaQuery.of(context).size.width * 0.4 - 20,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    expec,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),

                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(rating),
                      SizedBox(width: 16),
                      Text(noPeople),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        specialization,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(thickness: 1.0, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  // backgroundColor: Colors.deepOrangeAccent,
                  side: BorderSide(color: Colors.deepOrange),
                ),
                child: Text(
                  "View Profile",
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  side: BorderSide(color: Colors.deepOrange),
                ),
                child: Text(
                  "Book Appointments",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
