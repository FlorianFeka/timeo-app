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
                        _list.add(TimerWidget(time, timerName));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: _list,
      ),
      floatingActionButton: TimerCreatorWidget(addTimer),
    );
  }
}
