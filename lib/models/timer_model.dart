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

// OLD
// class TimerModel {
//   final int id;
//   String name; // or other properties
//   int remainingSeconds; // Countdown/Count-up time in seconds
//   bool isCountingUp;

//   TimerModel({
//     required this.id,
//     required this.name,
//     this.remainingSeconds = 600, // Initial countdown time
//     this.isCountingUp = false,
//   });
// }
