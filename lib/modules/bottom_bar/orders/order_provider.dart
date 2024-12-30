import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  bool isActive = false;

  onChangeIsActive(bool? confirmed, bool newValue) {
    if (confirmed == true) {
      isActive = newValue;
      notifyListeners();
    }
  }
}
