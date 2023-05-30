import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_kg_time.dart';

void main() {
  group('AmountPerKGTime', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerKGTime(-1, mcg, TimeUnit.hr),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check the to string method", () {
      expect('${AmountPerKGTime(2.4, U(factorToMG: 1), TimeUnit.hr)}',
          "2.4 U/kg/hr");
    });
  });
}
