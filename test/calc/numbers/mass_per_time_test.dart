import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_mass_time.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('AmountPerKGTime', () {
    test("throws an error if initialized with negative number", () {
      expect(
        () => MassPerTime(-6, microGram, TimeUnit.hr),
        throwAssertionError,
      );
    });
    test("check the to string method", () {
      expect(
        '${const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr)}',
        "2.4 U/hr",
      );
    });
    test("equality true", () {
      expect(
        const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
        true,
      );
    });
    test("equality different value", () {
      expect(
        const MassPerTime(2.5, U(factorToNg: 1), TimeUnit.hr) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
        false,
      );
    });
    test("equality different unit", () {
      expect(
        const MassPerTime(2.4, microGram, TimeUnit.hr) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
        false,
      );
    });
    test("equality different time unit", () {
      expect(
        const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.min) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
        false,
      );
    });
    test("equality different class", () {
      expect(
        // ignore: unrelated_type_equality_checks
        const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.min) ==
            const Mass(
              2.4,
              U(factorToNg: 1),
            ),
        false,
      );
    });
    test("equality different unit Time", () {
      expect(
        const MassPerTime(5, U(factorToNg: 1), TimeUnit.hr) ==
            const MassPerTime(60, U(factorToNg: 1), TimeUnit.min),
        false,
      );
    });
    test("roundTrip json", () {
      const massPerTime = MassPerTime(60, U(factorToNg: 1), TimeUnit.min);
      expect(MassPerTime.fromJson(massPerTime.toJson()), massPerTime);
    });
    test("roundTrip json", () {
      const massPerTime = MassPerTime(60, kiloGram, TimeUnit.min);
      expect(
        massPerTime.asNumber(gram, TimeUnit.hr),
        equals(3600000),
      );
    });
    test("wrong json", () {
      expect(
        () => MassPerTime.fromJson("4.5 mg/min/ml"),
        throwsFormatException,
      );
    });
    test("HashCode", () {
      const massPerTime = MassPerTime(60, U(factorToNg: 1), TimeUnit.min);
      const massPerTime2 = MassPerTime(60, U(factorToNg: 2), TimeUnit.min);

      expect(massPerTime.hashCode, isNot(massPerTime2.hashCode));
      expect(massPerTime.hashCode, massPerTime.hashCode);
    });
    test("equality different unit Time", () {
      expect(
        const MassPerTime(60, U(factorToNg: 1), TimeUnit.min) ==
            const MassPerTime(5, U(factorToNg: 1), TimeUnit.hr),
        false,
      );
    });
    test("equality different MassUnit and time unit", () {
      expect(
        const MassPerTime(60, milliGram, TimeUnit.min) ==
            const MassPerTime(5000, microGram, TimeUnit.hr),
        false,
      );
    });
    test("divide by volume", () {
      const concentration5mgPerMl = MassPerVolume(5, milliGram, VolumeUnit.ml);
      const massPerTime = MassPerTime(10000, microGram, TimeUnit.hr);
      expect(
        massPerTime / concentration5mgPerMl,
        const VolumePerTime(2, VolumeUnit.ml, TimeUnit.hr),
      );
    });
    test("divide by mass", () {
      const mass5Kg = Mass(5, kiloGram);
      const massPerTime = MassPerTime(100, gram, TimeUnit.hr);
      expect(
        massPerTime.divide(mass5Kg),
        const MassPerMassTime(20, gram, kiloGram, TimeUnit.hr),
      );
    });
  });
}
