import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml_time.dart';

void main() {
  group('AmountPerMLTime', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerMLTime(-4, mcg, TimeUnit.hr),
          throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${AmountPerMLTime(1.2, U(factorToMG: 1), TimeUnit.min)}',
          "1.2 U/ml/min");
    });
  });
}
