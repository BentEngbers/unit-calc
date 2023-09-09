import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('MassPerTime', () {
    test("zero value", () {
      expect(
        const MassPerTime.zero(),
        const MassPerTime(0, MassUnit.kiloGram, TimeUnit.second),
      );
    });
    test("multiply by time", () {
      expect(
        const MassPerTime(60, MassUnit.kiloGram, TimeUnit.hour) *
            (const Time.minutes(2)),
        const Mass(2, MassUnit.kiloGram),
      );
    });
    test("throws an error if initialized with negative number", () {
      expect(
        () => MassPerTime(-6, MassUnit.microGram, TimeUnit.hour),
        throwsAssertionError,
      );
    });
    test("check the to string method", () {
      expect(
        '${const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hour)}',
        "2.4 U/hr",
      );
    });
    test("equality true", () {
      expect(
        const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hour) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hour),
        true,
      );
    });
    test("equality different value", () {
      expect(
        const MassPerTime(2.5, U(factorToNg: 1), TimeUnit.hour) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hour),
        false,
      );
    });
    test("equality different unit", () {
      expect(
        const MassPerTime(2.4, MassUnit.microGram, TimeUnit.hour) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hour),
        false,
      );
    });
    test("equality different time unit", () {
      expect(
        const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.minute) ==
            const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hour),
        false,
      );
    });
    test("equality different class", () {
      expect(
        // ignore: unrelated_type_equality_checks
        const MassPerTime(2.4, U(factorToNg: 1), TimeUnit.minute) ==
            const Mass(
              2.4,
              U(factorToNg: 1),
            ),
        false,
      );
    });
    test("equality different unit Time", () {
      expect(
        const MassPerTime(5, U(factorToNg: 1), TimeUnit.hour) ==
            const MassPerTime(60, U(factorToNg: 1), TimeUnit.minute),
        false,
      );
    });
    test("roundTrip json", () {
      const massPerTime = MassPerTime(60, U(factorToNg: 1), TimeUnit.minute);
      expect(MassPerTime.fromJson(massPerTime.toJson()), massPerTime);
    });
    test("roundTrip json", () {
      const massPerTime = MassPerTime(60, MassUnit.kiloGram, TimeUnit.minute);
      expect(
        massPerTime.asNumber(MassUnit.gram, TimeUnit.hour),
        equals(3600000),
      );
    });
    test("wrong json", () {
      expect(
        () => MassPerTime.fromJson("4.5 mg/min/ml"),
        throwsInvalidJsonException,
      );
    });
    test("HashCode", () {
      const massPerTime = MassPerTime(60, U(factorToNg: 1), TimeUnit.minute);
      const massPerTime2 = MassPerTime(60, U(factorToNg: 2), TimeUnit.minute);

      expect(massPerTime.hashCode, isNot(massPerTime2.hashCode));
      expect(massPerTime.hashCode, massPerTime.hashCode);
    });
    test("equality different unit Time", () {
      expect(
        const MassPerTime(60, U(factorToNg: 1), TimeUnit.minute) ==
            const MassPerTime(5, U(factorToNg: 1), TimeUnit.hour),
        false,
      );
    });
    test("equality different MassUnit and time unit", () {
      expect(
        const MassPerTime(60, MassUnit.milliGram, TimeUnit.minute) ==
            const MassPerTime(5000, MassUnit.microGram, TimeUnit.hour),
        false,
      );
    });
    test("divide by volume", () {
      const concentration5mgPerMl =
          MassPerVolume(5, MassUnit.milliGram, VolumeUnit.milliLiters);
      const massPerTime = MassPerTime(10000, MassUnit.microGram, TimeUnit.hour);
      expect(
        massPerTime / concentration5mgPerMl,
        const VolumePerTime(2, VolumeUnit.milliLiters, TimeUnit.hour),
      );
    });
    test("divide by mass", () {
      const mass5Kg = Mass(5, MassUnit.kiloGram);
      const massPerTime = MassPerTime(100, MassUnit.gram, TimeUnit.hour);
      expect(
        massPerTime.divide(mass5Kg),
        const MassPerMassTime(
          20,
          MassUnit.gram,
          MassUnit.kiloGram,
          TimeUnit.hour,
        ),
      );
    });
  });
}
