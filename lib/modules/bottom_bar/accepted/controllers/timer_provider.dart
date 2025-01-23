import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  Duration _duration = Duration.zero;

  Duration get duration => _duration;
  bool get isRunning => _timer != null;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _duration += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  int pickUpRemainingSeconds = 600; //* 10 minutes in seconds
  bool _isCountingUp = false;
  //* Pickup Timer Getters
  // bool get isPickupRunning => _pickupTimer != null;

  //* Start Pickup Timer
  void startPickupTimer() {
    // if (_pickupTimer != null) return; // Prevent multiple timers
    // _pickupTimer =
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isCountingUp) {
        // Countdown logic
        if (pickUpRemainingSeconds > 0) {
          pickUpRemainingSeconds--;
        } else {
          _isCountingUp = true;
          pickUpRemainingSeconds = 600; // Switch to count-up
        }
      } else {
        // Count-up logic
        pickUpRemainingSeconds++;
      }
      log('pickUpRemainingSeconds: $pickUpRemainingSeconds');
      notifyListeners();
    });
  }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }
}
