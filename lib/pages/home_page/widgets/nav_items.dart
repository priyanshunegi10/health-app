import 'package:final_year_project/controller/bottom_navigation_controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavItems extends StatelessWidget {
  final String iconPath;
  final String label;
  final int index;
  const NavItems({
    super.key,
    required this.iconPath,
    required this.label,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    BottomNavigationController controller = Get.put(
      BottomNavigationController(),
    );
    return InkWell(
      onTap: () => controller.index.value = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // We wrap ONLY the parts that change color/style in Obx
          Obx(() {
            final isSelected = controller.index.value == index;
            return Image.asset(
              iconPath,
              height: 20,
              width: 20,
              // Optional: Change color if selected
              color: isSelected ? Colors.orange : Colors.grey,
            );
          }),
          const SizedBox(height: 4),
          Obx(() {
            final isSelected = controller.index.value == index;
            return Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Colors.orange
                    : Colors.black,
              ),
            );
          }),
        ],
      ),
    );
  }
}
