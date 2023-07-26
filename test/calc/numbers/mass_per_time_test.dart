import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_mass_time.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_time.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('AmountPerKGTime', () {
    test("throws an error if initialized with negative number", () {
      expect(
          () => MassPerTime(-6, microGram, TimeUnit.hr), throwAssertionError);
    });
    test("check the to string method", () {
      expect('${MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr)}', "2.4 U/hr");
    });
    test("equality true", () {
      expect(
          MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          true);
    });
    test("equality different value", () {
      expect(
          MassPerTime(2.5, U(factorToNg: 1), TimeUnit.hr) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different unit", () {
      expect(
          MassPerTime(2.4, microGram, TimeUnit.hr) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different time unit", () {
      expect(
          MassPerTime(2.4, U(factorToNg: 1), TimeUnit.min) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different class", () {
      expect(
          // ignore: unrelated_type_equality_checks
          MassPerTime(2.4, U(factorToNg: 1), TimeUnit.min) ==
              Mass(
                2.4,
                U(factorToNg: 1),
              ),
          false);
    });
    test("equality different unit Time", () {
      expect(
          MassPerTime(5, U(factorToNg: 1), TimeUnit.hr) ==
              MassPerTime(60, U(factorToNg: 1), TimeUnit.min),
          false);
    });
    test("roundTrip json", () {
      final massPerTime = MassPerTime(60, U(factorToNg: 1), TimeUnit.min);
      expect(MassPerTime.fromJson(massPerTime.toJson()), massPerTime);
    });
    test("roundTrip json", () {
      final massPerTime = MassPerTime(60, kiloGram, TimeUnit.min);
      expect(massPerTime.asNumber(massUnit: gram, perTimeUnit: TimeUnit.hr),
          equals(3600000));
    });
    test("wrong json", () {
      expect(
          () => MassPerTime.fromJson("4.5 mg/min/ml"), throwsFormatException);
    });
    test("HashCode", () {
      final massPerTime = MassPerTime(60, U(factorToNg: 1), TimeUnit.min);
      final massPerTime2 = MassPerTime(60, U(factorToNg: 2), TimeUnit.min);

      expect(massPerTime.hashCode, isNot(massPerTime2.hashCode));
      expect(massPerTime.hashCode, massPerTime.hashCode);
    });
    test("equality different unit Time", () {
      expect(
          MassPerTime(60, U(factorToNg: 1), TimeUnit.min) ==
              MassPerTime(5, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different MassUnit and time unit", () {
      expect(
          MassPerTime(60, milliGram, TimeUnit.min) ==
              MassPerTime(5000, microGram, TimeUnit.hr),
          false);
    });
    test("divide by volume", () {
      final concentration5mgPerMl = MassPerVolume(5, milliGram, VolumeUnit.ml);
      final massPerTime = MassPerTime(10000, microGram, TimeUnit.hr);
      expect(massPerTime / concentration5mgPerMl,
          VolumePerTime(2, VolumeUnit.ml, TimeUnit.hr));
    });
    test("divide by mass", () {
      final mass5Kg = Mass(5, kiloGram);
      final massPerTime = MassPerTime(100, gram, TimeUnit.hr);
      expect(massPerTime.divide(mass5Kg),
          MassPerMassTime(20, gram, kiloGram, TimeUnit.hr));
    });
  });
}
