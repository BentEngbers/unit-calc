import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_kg.dart';

void main() {
  group('AmountPerKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerKG(-1, microGram), throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${AmountPerKG(2.56, microGram)}', "2.56 mcg/kg");
    });
    test("equality false", () {
      expect(AmountPerKG(5, microGram) == Mass(5, microGram), false);
    });
    test("equality true", () {
      expect(AmountPerKG(5, microGram) == AmountPerKG(5, microGram), true);
    });
  });
}
