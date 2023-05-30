import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';

void main() {
  group('AmountPerML', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerML(-1, mcg),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check the to string method", () {
      expect('${AmountPerML(2.56, U(factorToMG: 1))}', "2.56 U/ml");
    });
  });
}
