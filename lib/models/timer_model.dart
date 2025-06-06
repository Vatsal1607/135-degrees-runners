class TimerModel {
  int remainingSeconds;
  bool isCountingUp;
  bool hasStarted;
  int totalSeconds;

  TimerModel({
    required this.remainingSeconds,
    this.isCountingUp = false,
    this.hasStarted = false,
    required this.totalSeconds,
  });

  double get progress => remainingSeconds / totalSeconds;
}
