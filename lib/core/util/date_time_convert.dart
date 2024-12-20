import 'package:intl/intl.dart';

class DateTimeConvert {
  static String convertDateToString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String getCurrentDate() {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ").format(DateTime.now());
  }
}
