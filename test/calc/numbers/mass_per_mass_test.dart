import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('AmountPerKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerMass.perKg(-1, MassUnit.microGram),
          throwsAssertionError);
    });
    test("check the to string method", () {
      expect('${const MassPerMass.perKg(2.56, MassUnit.microGram)}',
          "2.56 mcg/kg");
    });
    test("equality false", () {
      expect(
        const MassPerMass.perKg(5, MassUnit.microGram) ==
            const MassPerMass.perKg(5, MassUnit.gram),
        false,
      );
    });
    test("equality true", () {
      expect(
        const MassPerMass.perKg(5, MassUnit.microGram) ==
            const MassPerMass.perKg(5, MassUnit.microGram),
        true,
      );
    });
    test("equality true 2", () {
      expect(
        const MassPerMass.perKg(5000, MassUnit.gram) ==
            const MassPerMass.perKg(5, MassUnit.kiloGram),
        true,
      );
    });
    test("hashFunction", () {
      expect(
        const MassPerMass.perKg(5000, MassUnit.gram).hashCode,
        isNot(equals(const MassPerMass.perKg(5, MassUnit.kiloGram).hashCode)),
      );
    });
    test("json round trip", () {
      const massPerMass = MassPerMass.perKg(5000, MassUnit.gram);
      expect(MassPerMass.fromJson(massPerMass.toJson()), massPerMass);
    });
    test("bad json", () {
      expect(
        () => MassPerMass.fromJson("3.5 mg/kg/hr"),
        throwsInvalidJsonException,
      );
    });
    test("multiply with mass", () {
      expect(
        const MassPerMass(7, MassUnit.kiloGram, MassUnit.milliGram)
            .multiplyWithMass(const Mass.milliGrams(5)),
        const Mass.kiloGrams(35),
      );
    });
  });
}
