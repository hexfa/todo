import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/presentation/views/base/base-state.dart';

class TimerWidget extends StatefulWidget {
  final bool isStartTimer;
  final bool isShowControlButton;
  final Function() onStartChanged;
  final Function() onStopChanged;
  final Function() sumDurations;

  const TimerWidget(
      {super.key,
      required this.isStartTimer,
      required this.isShowControlButton,
      required this.onStartChanged,
      required this.onStopChanged,
      required this.sumDurations});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends BaseState<TimerWidget> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _seconds = widget.sumDurations();
    if (widget.isStartTimer) _startTimer();
  }

  void _startTimer() {
    _seconds = widget.sumDurations();
    _isRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
    if (mounted) {
      setState(() {});
    }
    // widget.onTimeChanged(_seconds);  // Update time when stopped
  }

  @override
  void dispose() {
    _stopTimer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isShowControlButton)
          InkWell(
            onTap: () {
              if (_isRunning) {
                widget.onStopChanged();
                _stopTimer();
              } else {
                widget.onStartChanged();
                _startTimer();
              }
            },
            child: Text(
              _isRunning ? '${localization.stop} :' : '${localization.start} :',
              style: theme.textTheme.titleMedium?.copyWith(
                  color: _isRunning ? theme.colorScheme.error : Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(width: 8),
        Text(
          DateTimeConvert.formatSecondsToTime(_seconds) == '00:00:00'
              ? DateTimeConvert.formatSecondsToTime(widget.sumDurations())
              : DateTimeConvert.formatSecondsToTime(_seconds),
          style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
