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
  String _name = "FILL";

  _TimerWidgetState() {
    _backUpDateTime = dateTime;
    initTimer();
  }

  updateScreenTime() {
    setState(() {
      _time = formatter.format(dateTime);
    });
  }

  initTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(oneSec, (timer) {
        if (dateTime.hour == 0 &&
            dateTime.minute == 0 &&
            dateTime.second == 0) {
          _timer.cancel();
        } else {
          dateTime = dateTime.subtract(oneSec);
          updateScreenTime();
        }
      });
    }
  }

  startTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(oneSec, (timer) {
        if (dateTime.hour == 0 &&
            dateTime.minute == 0 &&
            dateTime.second == 0) {
          _timer.cancel();
        } else {
          dateTime = dateTime.subtract(oneSec);
          updateScreenTime();
          setState(() {
            _playing = true;
            _playPauseIcon = Icons.pause;
          });
        }
      });
    }
  }

  playPause() {
    if (_playing) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  pauseTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      setState(() {
        _playing = false;
        _playPauseIcon = Icons.play_arrow;
      });
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
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            _name,
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          )
        ],
      ),
    );
  }
}
