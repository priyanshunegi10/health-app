import 'package:flutter/material.dart';

class AppointenmentCard extends StatelessWidget {
  final Color outercontaniner;
  final Color innercontaniner;
  final String date;
  final String time;
  final String drName;
  final String illness;

  const AppointenmentCard({
    super.key,
    required this.outercontaniner,
    required this.innercontaniner,
    required this.date,
    required this.time,
    required this.drName,
    required this.illness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.only(left: 15, right: 20, bottom: 12, top: 12),
      height: 170,
      width: MediaQuery.of(context).size.width * 0.8 + 10,
      decoration: BoxDecoration(
        color: outercontaniner,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: double.infinity,
            width: 90,
            decoration: BoxDecoration(
              color: innercontaniner,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(time, style: TextStyle(color: Colors.white)),
                      Text(
                        drName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(illness, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.more_horiz, color: Colors.white, size: 25),
        ],
      ),
    );
  }
}
