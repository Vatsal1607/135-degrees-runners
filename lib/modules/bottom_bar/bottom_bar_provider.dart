import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  PageController myPage = PageController(initialPage: 0);

  int currentIndex = 0;

  onPageChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  // * get dynamic greetings
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning,";
    } else if (hour < 17) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }
}
