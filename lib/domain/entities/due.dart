import 'package:equatable/equatable.dart';

class Due extends Equatable {
  final String date;
  final bool isRecurring;
  final String datetime;
  final String startTimer;
  final String timezone;

  const Due({
    required this.date,
    required this.isRecurring,
    required this.datetime,
    required this.startTimer,
    required this.timezone,
  });

  @override
  List<Object?> get props =>
      [date, isRecurring, datetime, startTimer, timezone];
}
