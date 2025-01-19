import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/socket/socket_service.dart';

class OrderProvider extends ChangeNotifier {
  bool isActive = false;
  final SocketService _socketService = SocketService();

  onChangeIsActive(bool? confirmed, bool newValue) {
    if (confirmed == true) {
      isActive = newValue;

      if (isActive) {
        // * Connect to socket server
        _socketService.connectToSocket();
      } else {
        // * Disconnect from socket server
        _socketService.disconnect();
      }

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
