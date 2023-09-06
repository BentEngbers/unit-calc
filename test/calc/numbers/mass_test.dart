import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/volume.dart';

import 'mass_per_volume_test.dart';

typedef UnitConversion = ({Mass from, Mass to});
typedef UnitConversionDivision = ({
  Mass amount,
  MassPerVolume divisor,
  Volume result,
});
void main() {
  group('Amount:', () {
    test("bad json test", () {
      expect(() => Mass.fromJson("FOO"), throwsFormatException);
    });
    test("bad json test", () {
      expect(() => Mass.fromJson("3.2 mg/ml"), throwsFormatException);
    });
    test("throws an error if initialized with negative number", () {
      expect(() => Mass(-1, microGram), throwAssertionError);
    });
    test("check the to string method", () {
      expect(const Mass(2.1, milliGram).toString(), "2.1 mg");
    });
    test(
      "equality different MassUnit",
      () => {expect(const Mass(1000, gram) == const Mass(1, kiloGram), true)},
    );
    test(
      "equality different value",
      () =>
          {expect(const Mass(5, milliGram) == const Mass(6, milliGram), false)},
    );
    test(
      "equality true",
      () =>
          {expect(const Mass(6, milliGram) == const Mass(6, milliGram), true)},
    );
    const cases = <UnitConversion>[
      (from: Mass(5, milliGram), to: Mass(5, milliGram)),
      (from: Mass(7, microGram), to: Mass(0.007, milliGram)),
      (from: Mass(9, nanoGram), to: Mass(0.009, microGram)),
      (from: Mass(6000000, nanoGram), to: Mass(6, milliGram))
    ];

    for (final testCase in cases) {
      final (:from, :to) = testCase;
      test("Test convertTo from $from to ${to.unit.displayName}", () {
        expect(from.as(from.unit), to);
      });
      test("json roundtrip", () {
        expect(Mass.fromJson(from.toJson()), equals(from));
      });
    }
    const divisionTestCases = <UnitConversionDivision>[
      (
        amount: Mass(5, milliGram),
        divisor: MassPerVolume(5, milliGram, VolumeUnit.ml),
        result: Volume.ml(1),
      ),
      (
        amount: Mass(7, microGram),
        divisor: MassPerVolume(0.007, milliGram, VolumeUnit.ml),
        result: Volume.ml(1)
      ),
      (
        amount: Mass(7, microGram),
        divisor: MassPerVolume(0.007, milliGram, VolumeUnit.ml),
        result: Volume.ml(1)
      ),
      (
        amount: Mass(60, nanoGram),
        divisor: MassPerVolume(0.004, microGram, VolumeUnit.ml),
        result: Volume.ml(15)
      ),
      (
        amount: Mass(60000000, nanoGram),
        divisor: MassPerVolume(6, milliGram, VolumeUnit.ml),
        result: Volume.ml(10)
      ),
    ];
    for (final tuple in divisionTestCases) {
      final (:amount, :divisor, :result) = tuple;
      test(
        "Test dividing $amount by $divisor",
        () => {expect(amount / divisor, equals(result))},
      );
      test(
        "Test dividing $divisor by $amount",
        () => {expect(amount.divide(result), equals(divisor))},
      );
    }
    const decreasingMassList = [
      Mass(1, kiloGram),
      Mass(999, gram),
      Mass(1, gram),
      Mass(999, milliGram),
      Mass(1, milliGram),
      Mass(999, microGram),
      Mass(1, microGram),
      Mass(999, nanoGram)
    ];
    for (final currentMass in decreasingMassList) {
      test("test $currentMass >= $currentMass", () {
        expect(currentMass >= currentMass, isTrue);
      });
      final elementsBefore =
          decreasingMassList.takeWhile((value) => value != currentMass);
      for (final massBefore in elementsBefore) {
        test("hashcode not equal", () {
          expect(currentMass.hashCode, isNot(equals(massBefore.hashCode)));
        });
        test("test $massBefore > $currentMass", () {
          expect(massBefore > currentMass, isTrue);
        });
        test("test $massBefore >= $currentMass", () {
          expect(currentMass >= massBefore, isFalse);
          expect(massBefore >= currentMass, isTrue);
        });
        test("test $currentMass < $massBefore", () {
          expect(massBefore < currentMass, isFalse);
          expect(currentMass < massBefore, isTrue);
        });
      }
    }
  });
}
