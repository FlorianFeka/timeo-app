import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimerCreatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        DatePicker.showTimePicker(context,
            showTitleActions: true, onConfirm: (time) {});
      },
    );
  }
}
