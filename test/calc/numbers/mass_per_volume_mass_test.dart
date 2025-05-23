import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume_mass.dart';

import 'mass_per_volume_test.dart';

// ignore: camel_case_types
typedef _testCase = ({double amountPerMlKg, double mass, double result});

void main() {
  group('AmountPerMLKG', () {
    test("throws an error if initialized with negative number", () {
      expect(
        () => MassPerVolumeMass.perKg(
          -4,
          MassUnit.microGram,
          VolumeUnit.milliLiters,
        ),
        throwsAssertionError,
      );
    });
    test("bad json", () {
      expect(
        () => MassPerVolumeMass.fromJson("4.2 mg/ml/kg/hr"),
        throwsInvalidJsonException,
      );
    });
    test("check the to string method", () {
      expect(
        '${const MassPerVolumeMass.perKg(0.0, MassUnit.microGram, VolumeUnit.milliLiters)}',
        "0 mcg/ml/kg",
      );
    });
    const testCases = <_testCase>[
      (amountPerMlKg: 5.0, mass: 6.0, result: 30.0),
      (amountPerMlKg: 1.0, mass: 4.0, result: 4.0),
      (amountPerMlKg: 0.0, mass: 5.0, result: 0.0),
    ];
    for (final testCase in testCases) {
      final (:amountPerMlKg, :mass, :result) = testCase;
      final massPerMlKg = MassPerVolumeMass.perKg(
        amountPerMlKg,
        const U(factorToNg: 1),
        VolumeUnit.milliLiters,
      );
      test("json round trip", () {
        expect(
          MassPerVolumeMass.fromJson(massPerMlKg.toJson()),
          equals(massPerMlKg),
        );
      });

      test("mass multiplication", () {
        expect(
          massPerMlKg * Mass(mass, const U(factorToNg: 1)),
          equals(
            MassPerVolume(
              result,
              const U(factorToNg: 1),
              VolumeUnit.milliLiters,
            ),
          ),
        );
      });
      final previousElements = testCases.takeWhile(
        (value) => value != testCase,
      );
      test("Check $massPerMlKg >= $massPerMlKg ", () {
        expect(massPerMlKg >= massPerMlKg, isTrue);
      });
      for (final previousElement in previousElements) {
        final previousMassPerMlKg = MassPerVolumeMass.perKg(
          previousElement.amountPerMlKg,
          const U(factorToNg: 1),
          VolumeUnit.milliLiters,
        );
        test("Check $previousMassPerMlKg > $massPerMlKg ", () {
          expect(previousMassPerMlKg > massPerMlKg, isTrue);
        });
        test("Check $previousMassPerMlKg > $massPerMlKg ", () {
          expect(previousMassPerMlKg >= massPerMlKg, isTrue);
        });
        test("Check $previousMassPerMlKg > $massPerMlKg ", () {
          expect(
            previousMassPerMlKg.hashCode,
            isNot(equals(massPerMlKg.hashCode)),
          );
        });
      }
    }
  });
}
