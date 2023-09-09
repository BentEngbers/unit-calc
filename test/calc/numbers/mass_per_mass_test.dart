import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('AmountPerKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerMass.perKg(-1, microGram), throwsAssertionError);
    });
    test("check the to string method", () {
      expect('${const MassPerMass.perKg(2.56, microGram)}', "2.56 mcg/kg");
    });
    test("equality false", () {
      expect(
        const MassPerMass.perKg(5, microGram) ==
            const MassPerMass.perKg(5, gram),
        false,
      );
    });
    test("equality true", () {
      expect(
        const MassPerMass.perKg(5, microGram) ==
            const MassPerMass.perKg(5, microGram),
        true,
      );
    });
    test("equality true 2", () {
      expect(
        const MassPerMass.perKg(5000, gram) ==
            const MassPerMass.perKg(5, kiloGram),
        true,
      );
    });
    test("hashFunction", () {
      expect(
        const MassPerMass.perKg(5000, gram).hashCode,
        isNot(equals(const MassPerMass.perKg(5, kiloGram).hashCode)),
      );
    });
    test("json round trip", () {
      const massPerMass = MassPerMass.perKg(5000, gram);
      expect(MassPerMass.fromJson(massPerMass.toJson()), massPerMass);
    });
    test("bad json", () {
      expect(() => MassPerMass.fromJson("3.5 mg/kg/hr"),
          throwsInvalidJsonException);
    });
    test("multiply with mass", () {
      expect(
          const MassPerMass(7, kiloGram, milliGram)
              .multiplyWithMass(const Mass.milliGrams(5)),
          const Mass.kiloGrams(35));
    });
  });
}
