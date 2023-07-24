import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_mass.dart';

void main() {
  group('AmountPerKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerMass.perKg(-1, microGram),
          throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${MassPerMass.perKg(2.56, microGram)}', "2.56 mcg/kg");
    });
    test("equality false", () {
      expect(
          MassPerMass.perKg(5, microGram) == MassPerMass.perKg(5, gram), false);
    });
    test("equality true", () {
      expect(MassPerMass.perKg(5, microGram) == MassPerMass.perKg(5, microGram),
          true);
    });
  });
}
