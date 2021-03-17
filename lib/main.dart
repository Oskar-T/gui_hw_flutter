import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GUI homework',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'GUI Homework'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> exercises = <String>["hw1", "hw2", "hw3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 250,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8.0),
            itemCount: exercises.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if(index == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FirstHW()));
                    } else if(index == 1) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SecondHW()));
                    } else if(index == 2) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ThirdHW()));
                    }
                  },
                  child: Container(
                    width: 225,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text('${exercises[index]}'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FirstHW extends StatefulWidget {

  @override
  _FirstHWState createState() => _FirstHWState();

}

class _FirstHWState extends State<FirstHW> {

  String dropdownValue = "One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go back"),

      ),
      body: Center(
          child: DropdownButton(
            value: dropdownValue,
            items: <String>['One', 'Two', 'Free']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                print(dropdownValue);
              });
            },
          )
      ),
    );
  }
}

class SecondHW extends StatefulWidget {


  @override
  _SecondHWState createState() => _SecondHWState();
}

class _SecondHWState extends State<SecondHW> {

  Stopwatch stopwatch;
  int state;
  Timer timer;

  void update() {
    setState(() {
      state = timer.tick;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => update());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Go back")),
      body: Center(
          child : Text("$state")
      ),
    );
  }
}


class ThirdHW extends StatefulWidget {

  @override
  _ThirdHWState createState() => _ThirdHWState();
}

class _ThirdHWState extends State<ThirdHW> {

  int textLength = 0;
  TextEditingController _controller;


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void length() {
    setState(() {
      textLength = _controller.text.length;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              onChanged: (text) {
                length();
              },
            ),
            Text("$textLength"),
            LinearProgressIndicator(
              value: textLength.toDouble()/10,
            )
          ],
        ),
      ),
    );
  }

}


