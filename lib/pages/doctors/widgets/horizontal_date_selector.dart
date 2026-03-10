import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class HorizontalDateSelector extends StatefulWidget {
  // Yeh function parent widget (Schedule Page) ko batayega ki konsi date select hui
  final Function(DateTime) onDateSelected;

  const HorizontalDateSelector({super.key, required this.onDateSelected});

  @override
  State<HorizontalDateSelector> createState() => _HorizontalDateSelectorState();
}

class _HorizontalDateSelectorState extends State<HorizontalDateSelector> {
  int selectedIndex = 0; // By default Aaj ki date (index 0) selected hai
  final int daysToShow = 30; // Agle 30 din tak ki dates dikhayega

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90, // Screenshot jaisi height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysToShow,
        itemBuilder: (context, index) {
          // LOGIC: Aaj ki date mein loop ka index add kar do (0 din, 1 din, 2 din...)
          DateTime currentDate = DateTime.now().add(Duration(days: index));

          // Formatting logic: "d" se number aayega (3, 4, 5), "E" se day aayega (Sat, Sun, Mon)
          String dayNumber = DateFormat('d').format(currentDate);
          String dayName = DateFormat('E').format(currentDate);

          bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // Parent ko selected date bhejna
              widget.onDateSelected(currentDate);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              width: 65,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2E8B90) : Colors.white, // Teal vs White
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayNumber,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}