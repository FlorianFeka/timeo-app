import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimerCreatorWidget extends StatelessWidget {
  final Function addTimerFunction;

  TimerCreatorWidget(this.addTimerFunction);

  void showWrongTimeValidation(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Timer time"),
            content: Text("Please enter a time greather than 0 seconds!"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        DatePicker.showTimePicker(context,
            showTitleActions: true,
            currentTime: DateTime(2000), onConfirm: (time) {
          if (time.hour == 0 && time.minute == 0 && time.second == 0) {
            this.showWrongTimeValidation(context);
            return;
          }
          this.addTimerFunction(time);
        });
      },
    );
  }
}
