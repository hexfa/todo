import 'package:intl/intl.dart';

class DateTimeConvert {
  static String convertDateToString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
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
      print("Error parsing date: $e");
      return 0;
    }
  }

  static String formatSecondsToTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$remainingSeconds';
  }
}
