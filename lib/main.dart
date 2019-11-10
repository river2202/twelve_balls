import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BallsQuiz/bloc.dart';
import 'View/GamePlayScreen.dart';
import 'View/TwelveBallsQuiz.dart';

void main() {
  runApp(TwelveBallsQuizApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '12 Balls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePlayScreen(),
    );
  }
}

class TwelveBallsQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          builder: (BuildContext context) => BallsQuizBloc(12),
          child: TwelveBallsQuizPage(title: '12 Balls Challenge')),
    );
  }
}