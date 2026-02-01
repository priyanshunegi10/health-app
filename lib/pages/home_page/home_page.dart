import 'package:final_year_project/pages/home_page/widgets/appointenment_card.dart';
import 'package:final_year_project/pages/home_page/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          child: Image.asset("assets/icons/greeting.png"),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Priyanshu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset("assets/icons/user.png"),
                        ),
                      ],
                    )
                    .animate()
                    .fade(duration: 1000.ms)
                    .slideY(begin: -1, end: 0, curve: Curves.easeOut),
                SizedBox(height: 35),
                TextField(
                      decoration: InputDecoration(
                        hintText: "Search Medical Services",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    )
                    .animate(delay: 300.ms) // Wait 200ms before starting
                    .fade(duration: 600.ms),

                SizedBox(height: 35),
                Row(
                  children: [
                    Text(
                      "Services",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ).animate(delay: 500.ms).fade(duration: 1000.ms),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ServicesCard(
                          height: 90,
                          width: 80,
                          color: Colors.purple.shade100,
                          imagePath: "assets/icons/doctor.png",
                        ),
                        ServicesCard(
                          height: 90,
                          width: 80,
                          color: Colors.orange.shade100,
                          imagePath: "assets/icons/medicine.png",
                        ),
                        ServicesCard(
                          height: 90,
                          width: 80,
                          color: Colors.blue.shade100,
                          imagePath: "assets/icons/medical-report.png",
                        ),
                        ServicesCard(
                          height: 90,
                          width: 80,
                          color: Colors.red.shade100,
                          imagePath: "assets/icons/virus.png",
                        ),
                      ],
                    )
                    .animate(delay: 400.ms)
                    .slideX(
                      begin: -1,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.fastOutSlowIn,
                    )
                    .fade(),
                Container(
                      height: 190,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(20),
                      //   child: Image.asset(
                      //     "assets/images/clinic.jpeg",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    )
                    .animate(delay: 600.ms)
                    .slideX(
                      begin: 1,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.fastOutSlowIn,
                    )
                    .fade(),

                SizedBox(height: 25),

                Row(
                  children: [
                    Text(
                      "Upcoming Appointments",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ).animate(delay: 800.ms).fade(duration: 1000.ms),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                            children: [
                              AppointenmentCard(
                                outercontaniner: Color(0xff22BED5),
                                innercontaniner: Color(0xff0294AD),
                                date: '12\ntue',
                                time: '9:30 AM',
                                drName: 'Dr. Mim Akhter',
                                illness: 'Depression',
                              ),
                              AppointenmentCard(
                                outercontaniner: Color(0xff22BED5),
                                innercontaniner: Color(0xff0294AD),
                                date: '12\ntue',
                                time: '9:30 AM',
                                drName: 'Dr. Mim Akhter',
                                illness: 'Depression',
                              ),
                              AppointenmentCard(
                                outercontaniner: Color(0xff22BED5),
                                innercontaniner: Color(0xff0294AD),
                                date: '12\ntue',
                                time: '9:30 AM',
                                drName: 'Dr. Mim Akhter',
                                illness: 'Depression',
                              ),
                              AppointenmentCard(
                                outercontaniner: Color(0xff22BED5),
                                innercontaniner: Color(0xff0294AD),
                                date: '12\ntue',
                                time: '9:30 AM',
                                drName: 'Dr. Mim Akhter',
                                illness: 'Depression',
                              ),
                            ],
                          )
                          .animate(delay: 900.ms)
                          .slideY(
                            begin: 1,
                            end: 0,
                            duration: 600.ms,
                            curve: Curves.easeOut,
                          ) // From Bottom
                          .fade(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
