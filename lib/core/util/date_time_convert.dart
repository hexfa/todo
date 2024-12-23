import 'package:intl/intl.dart';

class DateTimeConvert {
  static String convertDateToString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String wrapDateToString(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  static String getCurrentDate() {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
  }

  static int calculateSecondsDifference(String startDate) {
    try {
      final DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      final DateTime parsedTime = format.parse(startDate, true);
      final DateTime currentTime = format.parse(getCurrentDate(), true);
      final Duration difference = currentTime.difference(parsedTime);
      return difference.inSeconds;
    } catch (e) {
      if (e is FormatException) {
        print("Error parsing date due to format: $e");
      } else {
        print("An unexpected error occurred: $e");
      }
      return 0;
    }
  }

  static String formatSecondsToTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$remainingSeconds';
  }

  static bool isDateBeforeToday(DateTime date) {
    try {
      DateTime today = DateTime.now();
      today = DateTime(today.year, today.month, today.day);
      return date.isBefore(today);
    } catch (e) {
      print(date);
      print("Invalid date format: $e");
      return false;
    }
  }

  static bool isSecondDateValid(DateTime firstDate, DateTime secondDate) {
    try {
      return !secondDate.isBefore(firstDate);
    } catch (e) {
      print("Invalid date format: $e");
      return false;
    }
  }
}
