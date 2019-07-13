import 'package:test/test.dart';
import 'package:twelve_balls/Ball.dart';

void main() {
  test('Ball status', () {
    var index = 0;
    var balls = Status.values.map((value) => Ball(index++, value)).toList();

    var ballIsWeighted = [false, true, true, true];
  
    balls.forEach((item) {
      print('ball[${item.index}] is weighted = ${item.isWeighted()}');
      expect(item.isWeighted(), ballIsWeighted[item.index]);
    });
  });
}