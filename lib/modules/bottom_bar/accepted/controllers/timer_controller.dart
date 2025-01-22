import 'dart:async';
import 'package:flutter/material.dart';

class TimerController extends ChangeNotifier {
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
