import 'package:final_year_project/controller/bottom_navigation_controller/bottom_navigation_controller.dart';
import 'package:final_year_project/pages/home_page/widgets/nav_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({super.key});

  final BottomNavigationController controller = Get.put(
    BottomNavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. The Body switches based on index
      body: Obx(() => controller.pages[controller.index.value]),

      // 2. The Floating Action Button (Center Mic)
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            // Set index to 2 (ChatBot) when center button is clicked
            controller.index.value = 2;
          },
          elevation: 4,
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(
              "assets/icons/chatbot.png",
              height: 40,
              width: 40,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 3. The Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 10,
        height: 80,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // FIX: Distributes space evenly
          children: [
            // Left Side
            NavItems(
              iconPath: "assets/icons/home.png",
              label: "Home",
              index: 0,
            ),
            NavItems(
              iconPath: "assets/icons/consultation.png",
              label: "Consult",
              index: 1,
            ),

            // Spacer for the Center Button
            const SizedBox(width: 40),

            // Right Side (Note: Indexes match your pages list)
            NavItems(
              iconPath: "assets/icons/report.png",
              label: "Care Plan",
              index: 3,
            ),
            NavItems(
              iconPath: "assets/icons/menu.png",
              label: "More",
              index: 4,
            ),
          ],
        ),
      ),
    );
  }
}
