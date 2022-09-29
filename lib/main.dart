import 'dart:math';

import 'package:dynamic_island_flutter/packages/widget/widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "Initialize";

  int homeScore = 0, awayScore = 0;

  void _startMatch() {
    LiveActivities.instance.startLiveActivity();
    _counter = "Running";
    setState(() {});
  }

  void _stopMatch() {
    LiveActivities.instance.stopLiveActivity();
    _counter = "Ending";
    setState(() {});
  }


  void _updateScoreMatch() {
    var rand = Random();
    final score = rand.nextInt(100);
    final scoreSide = rand.nextBool();
    if(scoreSide) {
      homeScore += score;
    } else {
      awayScore += score;
    }
    _counter = "MU: $homeScore - MC: $awayScore";
    LiveActivities.instance.updateLiveActivity(homeScore: homeScore, awayScore: awayScore);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _counter,
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(children: [
              IconButton(onPressed: _startMatch, icon: const Icon(Icons.play_arrow)),
              IconButton(onPressed: _stopMatch, icon: const Icon(Icons.pause)),
              IconButton(onPressed: _updateScoreMatch, icon: const Icon(Icons.update)),
            ]),
          ],
        ),
      ),
    );
  }
}
