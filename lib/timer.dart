import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:async';

class TimerWidget extends StatefulWidget {
  final DateTime _dateTimeRoot;
  final String _timerName;

  TimerWidget(this._dateTimeRoot, this._timerName);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final DateFormat formatter = new DateFormat('Hms');
  final Duration oneSec = new Duration(seconds: 1);
  DateTime _dateTime;
  DateTime _backUpDateTime;
  Timer _timer;
  String _time = "";
  IconData _playPauseIcon = Icons.pause;
  bool _playing = true;
  String _name;

  _TimerWidgetState() {
    initTimer();
  }

  updateScreenTime() {
    setState(() {
      _time = formatter.format(_dateTime);
    });
  }

  initTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(oneSec, (timer) {
        if (_dateTime.hour == 0 &&
            _dateTime.minute == 0 &&
            _dateTime.second == 0) {
          _timer.cancel();
        } else {
          _dateTime = _dateTime.subtract(oneSec);
          updateScreenTime();
        }
      });
    }
  }

  startTimer() {
    if (_timer == null) {
      _timer = new Timer.periodic(oneSec, (timer) {
        if (_dateTime.hour == 0 &&
            _dateTime.minute == 0 &&
            _dateTime.second == 0) {
          _timer.cancel();
        } else {
          _dateTime = _dateTime.subtract(oneSec);
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

    _dateTime = _backUpDateTime;
    _dateTime = _dateTime.subtract(oneSec);
    updateScreenTime();
  }

  resetTimer() {
    _dateTime = _backUpDateTime;
    _dateTime = _dateTime.subtract(oneSec);
    pauseTimer();
    updateScreenTime();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (_dateTime == null) {
      _dateTime = widget._dateTimeRoot;
      _backUpDateTime = _dateTime;
      _name = widget._timerName;
    }
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
              ),
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: resetTimer,
              )
            ],
          )
        ],
      ),
    );
  }
}
