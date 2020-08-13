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
  final DateFormat formatter = new DateFormat('Hms');
  final Duration oneSec = new Duration(seconds: 1);
  Timer _timer;
  String _time = "";

  startTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(oneSec, (timer) {
        dateTime = dateTime.subtract(oneSec);
        print(dateTime);
        setState(() {
          _time = formatter.format(dateTime);
        });
        if (dateTime.hour == 0 &&
            dateTime.minute == 0 &&
            dateTime.second == 0) {
          print('Stop Timer');
          _timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Row(
      children: [
        Text(
          _time,
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }
}
