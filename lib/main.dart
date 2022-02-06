import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Game/World.dart';
import 'View/GameStartScreen.dart';
import 'View/TwelveBallsQuiz.dart';

void main() {
  runApp(Provider(
    create: (_) => new World(),
    lazy: false,
    child: TwelveBallsQuizApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '12 Balls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: TwelveBallsQuizPage(title: '12 Balls Challenge'),
      home: GameStartScreen(),
    );
  }
}

class TwelveBallsQuizApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TwelveBallsQuizPage(title: '12 Balls Challenge'),
    );
  }
}
