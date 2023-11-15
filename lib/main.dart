import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twelve_balls/View/TwelveBallsQuizPageOld.dart';

import 'View/GameStartScreen.dart';
import 'View/TwelveBallsQuizPageNew.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '12 Balls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameStartScreen(),
    );
  }
}

class TwelveBallsQuizApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'TradeGothicLTStd-Bold',
      ),
      debugShowCheckedModeBanner: false,
      home: ref.watch(testNewFeatureToggleProvider)
          ? TwelveBallsQuizPageNew()
          : TwelveBallsQuizPage(title: '12 Balls Challenge'),
    );
  }
}

/// todo: remove this feature toggle after refactoring
final testNewFeatureToggleProvider = Provider<bool>((ref) {
  return true;
});
