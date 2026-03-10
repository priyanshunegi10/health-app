import 'package:flutter/material.dart';

class DailyHealthTipCard extends StatelessWidget {
  const DailyHealthTipCard({super.key});

  @override
  Widget build(BuildContext context) {
   
    List<String> healthTips = [
      "Drink at least 8 glasses of water today to stay hydrated and keep your energy levels up.",
      "A 30-minute walk daily can reduce the risk of heart disease and improve mental health.",
      "Limit your screen time 1 hour before bed to improve your sleep quality.",
      "Eating a handful of nuts daily provides healthy fats and keeps your brain sharp.",
      "Deep breathing for just 5 minutes can instantly lower your stress and blood pressure."
    ];

  
    int tipIndex = DateTime.now().day % healthTips.length;
    String todayTip = healthTips[tipIndex];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E8B90), Color(0xFF1A6B70)], 
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E8B90).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.lightbulb_outline, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 15),
              const Text(
                "Tip of the Day",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            todayTip,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}