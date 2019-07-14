import 'package:test/test.dart';
import 'package:twelve_balls/Ball.dart';
import 'package:twelve_balls/Balls.dart';
import 'package:twelve_balls/Quiz.dart';
import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

void main() {

  group('12 Balls tests', () {
    test("Ball init from symbol", () {
      var quiz = Quiz(12);

    });
  });
}