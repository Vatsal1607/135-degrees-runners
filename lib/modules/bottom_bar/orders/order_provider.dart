import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderProvider extends ChangeNotifier {
  bool isActive = false;

  onChangeIsActive(bool? confirmed, bool newValue) {
    if (confirmed == true) {
      isActive = newValue;
      notifyListeners();
    }
  }

  double dragPosition = 10.w; // Track the drag position
  final double maxDrag = 280.w; // Maximum drag length
  final minDrag = 10.w;
  bool isConfirmed = false; // Track if the action is confirmed

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    dragPosition += details.delta.dx;
    // Prevent sliding left
    if (dragPosition < 0) {
      dragPosition = 10.w;
    }
    // Limit max drag
    if (dragPosition > maxDrag) {
      dragPosition = maxDrag;
    }
    notifyListeners(); // Notify listeners of the change
  }

  void onHorizontalDragEnd(details, context) {
    if (dragPosition >= maxDrag * 0.8) {
      // Action confirmed
      isConfirmed = true;
      dragPosition = maxDrag; // Snap to the end
      debugPrint("Order Placed!");
      // Navigator.pushNamed(context, Routes.orderStatus);
    } else {
      // Reset position
      dragPosition = 10.w;
      isConfirmed = false;
    }
    notifyListeners();
  }
}
