import 'package:flutter/material.dart';
import 'package:timeo/timer-creator.dart';
import 'package:timeo/timer.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Timeo'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TimerWidget> _list;
  var _timerId = 0;

  _HomePageState() {
    _list = [];
  }

  addTimer(DateTime time) {
    String timerName = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Timer Name"),
            content: TextField(
              onChanged: (String textTyped) {
                setState(() {
                  timerName = textTyped;
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Enter name'),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      setState(() {
                        _list.add(TimerWidget(
                            UniqueKey(), time, timerName, deleteTimer));
                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  deleteTimer(Key key) {
    setState(() {
      this._list.removeWhere((timerWidget) {
        if (timerWidget.key == key) {
          return true;
        } else {
          return false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _list.isEmpty
          ? Center(
              child: Text("No timers"),
            )
          : Column(
              children: _list,
            ),
      floatingActionButton: TimerCreatorWidget(addTimer),
    );
  }
}
