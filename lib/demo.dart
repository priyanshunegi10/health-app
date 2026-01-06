import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import this

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: Slides down from Top
              Row(
                children: [
                  CircleAvatar(radius: 24, backgroundColor: Colors.grey[300]),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello", style: TextStyle(color: Colors.grey)),
                      Text("Yasir Bangash", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.notifications_none)
                ],
              )
              .animate()
              .fade(duration: 500.ms)
              .slideY(begin: -1, end: 0, curve: Curves.easeOut), // Comes from Top

              SizedBox(height: 20),

              // 2. Search Bar: Fades in slightly later
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.search),
              )
              .animate(delay: 200.ms) // Wait 200ms before starting
              .fade(duration: 500.ms),

              SizedBox(height: 20),

              Text("Services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              .animate(delay: 300.ms)
              .fade(),

              SizedBox(height: 10),

              // 3. Services Row: Icons slide in from the LEFT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIcon(Colors.blue),
                  _buildIcon(Colors.orange),
                  _buildIcon(Colors.purple),
                  _buildIcon(Colors.red),
                ],
              )
              .animate(delay: 400.ms) // Delays keep increasing to create "flow"
              .slideX(begin: -1, end: 0, duration: 600.ms, curve: Curves.fastOutSlowIn) // From Left
              .fade(),

              SizedBox(height: 20),

              // 4. Banner: Slides in from the RIGHT
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(16)),
                child: Center(child: Text("Get Best Medical Services", style: TextStyle(color: Colors.white))),
              )
              .animate(delay: 600.ms)
              .slideX(begin: 1, end: 0, duration: 600.ms, curve: Curves.fastOutSlowIn) // From Right
              .fade(),

              SizedBox(height: 20),
              
              Text("Upcoming Appointment", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              .animate(delay: 800.ms)
              .fade(),

              SizedBox(height: 10),

              // 5. Appointment Card: Slides up from BOTTOM
              Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.blue[900], borderRadius: BorderRadius.circular(16)),
              )
              .animate(delay: 900.ms)
              .slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOut) // From Bottom
              .fade(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return Container(
      width: 60, height: 60,
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Icon(Icons.medical_services, color: color),
    );
  }
}