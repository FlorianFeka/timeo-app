import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimerCreatorWidget extends StatelessWidget {
  final Function addTimerFunction;

  TimerCreatorWidget(this.addTimerFunction);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        DatePicker.showTimePicker(context,
            showTitleActions: true,
            currentTime: DateTime(2000), onConfirm: (time) {
          this.addTimerFunction(time);
        });
      },
    );
  }
}
