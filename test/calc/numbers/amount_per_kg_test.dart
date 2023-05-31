import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_kg.dart';

void main() {
  group('AmountPerKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerKG(-1, mcg), throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${AmountPerKG(2.56, mcg)}', "2.56 mcg/kg");
    });
    test("equality false", () {
      expect(AmountPerKG(5, mcg) == Amount(5, mcg), false);
    });
    test("equality true", () {
      expect(AmountPerKG(5, mcg) == AmountPerKG(5, mcg), true);
    });
  });
}
