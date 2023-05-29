import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerMLTime.dart';

void main() {
  group('AmountPerMLTime', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerMLTime(-4, mcg, TimeUnit.hr),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check the to string method", () {
      expect('${AmountPerMLTime(1.2, U, TimeUnit.min)}', "1.2 U/ml/min");
    });
  });
}
