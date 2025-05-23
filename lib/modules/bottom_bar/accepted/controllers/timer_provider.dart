import 'dart:async';
import 'package:degrees_runners/models/timer_model.dart';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  Duration _duration = Duration.zero;

  Duration get duration => _duration;
  bool get isRunning => _timer != null;

  void startInfinityTimer() {
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

  final Map<int, TimerModel> pickedUpTimers = {};

  TimerModel getPickedUpTimer(int index) {
    if (!pickedUpTimers.containsKey(index)) {
      pickedUpTimers[index] =
          TimerModel(remainingSeconds: 600, totalSeconds: 600);
    }
    return pickedUpTimers[index]!;
  }

  //* Start Pickup Timer
  void startPickedUpTimer(int index) {
    TimerModel timerModel = getPickedUpTimer(index);
    if (!timerModel.hasStarted) {
      timerModel.hasStarted = true; // Mark the timer as started
      Timer.periodic(const Duration(seconds: 1), (timerInstance) {
        if (!timerModel.isCountingUp) {
          if (timerModel.remainingSeconds > 0) {
            timerModel.remainingSeconds--;
            debugPrint("Notify UI: ${timerModel.remainingSeconds}");
          } else {
            timerModel.isCountingUp = true;
            timerModel.remainingSeconds = 600; // Reset to count-up
          }
        } else {
          timerModel.remainingSeconds++;
        }
        debugPrint("Notify UI: ${timerModel.remainingSeconds}");
        notifyListeners();
      });
      notifyListeners(); // Notify listeners about the initial change
    }
  }

  // void startPickedUpTimer(int index) {
  //   final timerModel = getPickedUpTimer(index);
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (!timerModel.isCountingUp) {
  //       if (timerModel.remainingSeconds > 0) {
  //         timerModel.remainingSeconds--;
  //       } else {
  //         timerModel.isCountingUp = true;
  //         timerModel.remainingSeconds = 600; // Reset to count-up
  //       }
  //     } else {
  //       timerModel.remainingSeconds++;
  //     }
  //     notifyListeners();
  //   });
  // }

  // int deliveryRemainingSeconds = 900; //* 15 minutes in seconds
  final Map<int, TimerModel> deliveryTimers = {};

  TimerModel getDeliveryTimer(int index) {
    if (!deliveryTimers.containsKey(index)) {
      deliveryTimers[index] =
          TimerModel(remainingSeconds: 900, totalSeconds: 900);
    }
    return deliveryTimers[index]!;
  }

  // final List<TimerModel> _timers = [];

  //* Start Delivery Timer
  void startDeliveryTimer(int index) {
    TimerModel timer = getDeliveryTimer(index);
    if (!timer.hasStarted) {
      timer.hasStarted = true; // Mark the timer as started
      Timer.periodic(const Duration(seconds: 1), (timerInstance) {
        if (!timer.isCountingUp) {
          if (timer.remainingSeconds > 0) {
            timer.remainingSeconds--;
          } else {
            timer.isCountingUp = true;
            timer.remainingSeconds = 900; // Reset to count-up
          }
        } else {
          timer.remainingSeconds++;
        }
        notifyListeners();
      });
      notifyListeners(); // Notify listeners about the initial change
    }
  }

  // void startDeliveryTimer(int index) {
  //   final timerModel = getDeliveryTimer(index);
  //   TimerModel timer = _timers[index];
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (!timerModel.isCountingUp) {
  //       if (timerModel.remainingSeconds > 0) {
  //         timerModel.remainingSeconds--;
  //       } else {
  //         timerModel.isCountingUp = true;
  //         timerModel.remainingSeconds = 900; // Reset to count-up
  //       }
  //     } else {
  //       timerModel.remainingSeconds++;
  //     }
  //     notifyListeners();
  //   });
  // }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }
}
