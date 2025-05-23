import 'package:intl/intl.dart';

class Utils {
  /// Formats a DateTime string into the 'h:mm a' format (e.g., 9:51 AM).
  static String formatTime(String dateTimeString) {
    try {
      // Parse the DateTime string
      DateTime dateTime = DateTime.parse(dateTimeString).toLocal();

      // Format the time as hh:mm a
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      // Handle invalid DateTime strings gracefully
      return '$dateTimeString';
    }
  }
}
