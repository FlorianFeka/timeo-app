import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:async';

class TimerWidget extends StatefulWidget {
  // final DateTime _dateTime;

  // TimerWidget(this._dateTime);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  DateTime dateTime = new DateTime(1, 1, 1, 0, 0, 11);
  DateTime backUpDateTime = null;
  final DateFormat formatter = new DateFormat('Hms');
  final Duration oneSec = new Duration(seconds: 1);
  Timer _timer;
  String _time = "";

  _TimerWidgetState() {
    backUpDateTime = dateTime;
    startTimer();
  }

  updateScreenTime() {
    setState(() {
      _time = formatter.format(dateTime);
    });
  }

  startTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(oneSec, (timer) {
        dateTime = dateTime.subtract(oneSec);
        print(dateTime);
        updateScreenTime();
        if (dateTime.hour == 0 &&
            dateTime.minute == 0 &&
            dateTime.second == 0) {
          print('Stop Timer');
          _timer.cancel();
        }
      });
    }
  }

  pauseTimer() {
    _timer.cancel();
    _timer = null;
  }

  stopTimer() {
    pauseTimer();

    dateTime = backUpDateTime;
    dateTime = dateTime.subtract(oneSec);
    updateScreenTime();
  }

  resetTimer() {
    dateTime = backUpDateTime;
    dateTime = dateTime.subtract(oneSec);
    _timer = null;
    updateScreenTime();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _time,
          style: TextStyle(fontSize: 30),
        ),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: startTimer,
        ),
        IconButton(
          icon: Icon(Icons.pause),
          onPressed: pauseTimer,
        ),
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: stopTimer,
        ),
        IconButton(
          icon: Icon(Icons.replay),
          onPressed: resetTimer,
        )
      ],
    );
  }
}
