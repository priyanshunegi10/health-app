import 'package:final_year_project/pages/care_plan/care_plan_page.dart';
import 'package:final_year_project/pages/chat_bot/chat_bot_page.dart';
import 'package:final_year_project/pages/doctors/doctors_page.dart';
import 'package:final_year_project/pages/home_page/home_page.dart';
import 'package:final_year_project/pages/more/more_page.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    HomePage(), // 0
    DoctorsPage(), // 1
    ChatBot(), // 2 
    CarePlanPage(), // 3
    MorePage(), // 4
  ];

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }
}
