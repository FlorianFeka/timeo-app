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
  final DateFormat formatter = new DateFormat('Hms');
  final Duration oneSec = new Duration(seconds: 1);
  DateTime dateTime = new DateTime(1, 1, 1, 0, 0, 11);
  DateTime _backUpDateTime;
  Timer _timer;
  String _time = "";
  IconData _playPauseIcon = Icons.pause;
  bool _playing = true;

  _TimerWidgetState() {
    _backUpDateTime = dateTime;
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
        updateScreenTime();
        if (dateTime.hour == 0 &&
            dateTime.minute == 0 &&
            dateTime.second == 0) {
          _timer.cancel();
        }
      });
    }
  }

  playPause() {
    if (_playing) {
      setState(() {
        _playing = false;
        _playPauseIcon = Icons.play_arrow;
      });
      pauseTimer();
    } else {
      setState(() {
        _playing = true;
        _playPauseIcon = Icons.pause;
      });
      startTimer();
    }
  }

  pauseTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  stopTimer() {
    pauseTimer();

    dateTime = _backUpDateTime;
    dateTime = dateTime.subtract(oneSec);
    updateScreenTime();
  }

  resetTimer() {
    dateTime = _backUpDateTime;
    dateTime = dateTime.subtract(oneSec);
    pauseTimer();
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
          icon: Icon(_playPauseIcon),
          onPressed: playPause,
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
