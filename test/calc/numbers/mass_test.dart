import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

typedef UnitConversion = ({Mass from, Mass to});
typedef UnitConversionDivision =
    ({Mass amount, MassPerVolume divisor, Volume result});

typedef MassDivisionTestCase =
    ({Mass dividend, Mass divisor, MassPerMass answer});

void main() {
  group('Amount:', () {
    test("bad json test", () {
      expect(() => Mass.fromJson("FOO"), throwsFormatException);
    });
    test("bad json test", () {
      expect(() => Mass.fromJson("3.2 mg/ml"), throwsInvalidJsonException);
    });
    test("throws an error if initialized with negative number", () {
      expect(() => Mass(-1, MassUnit.microGram), throwsAssertionError);
    });
    test("kiloMassUnit.grams an error if initialized with negative number", () {
      expect(() => Mass.kiloGrams(-1), throwsAssertionError);
    });
    test("kiloMassUnit.grams an error if initialized with negative number", () {
      expect(const Mass.zero(), const Mass.milliGrams(0));
    });
    test("check the to string method", () {
      expect(const Mass(2.1, MassUnit.milliGram).toString(), "2.1 mg");
    });
    test(
      "equality different MassUnit",
      () => {
        expect(
          const Mass(1000, MassUnit.gram) == const Mass(1, MassUnit.kiloGram),
          isTrue,
        ),
      },
    );
    test(
      "equality different value",
      () => {
        expect(
          const Mass(5, MassUnit.milliGram) ==
              const Mass(6, MassUnit.milliGram),
          isFalse,
        ),
      },
    );
    test(
      "equality true",
      () => {
        expect(
          const Mass(6, MassUnit.milliGram) ==
              const Mass(6, MassUnit.milliGram),
          isTrue,
        ),
      },
    );
    test(
      "subtract",
      () => {
        expect(
          const Mass.kiloGrams(1) - const Mass(500, MassUnit.gram),
          const Mass(500, MassUnit.gram),
        ),
      },
    );
    test(
      "addition",
      () => {
        expect(
          const Mass(1, MassUnit.gram) + const Mass(5000, MassUnit.milliGram),
          const Mass(6, MassUnit.gram),
        ),
      },
    );
    const cases = <UnitConversion>[
      (from: Mass(5, MassUnit.milliGram), to: Mass(5, MassUnit.milliGram)),
      (from: Mass(7, MassUnit.microGram), to: Mass(0.007, MassUnit.milliGram)),
      (from: Mass(9, MassUnit.nanoGram), to: Mass(0.009, MassUnit.microGram)),
      (from: Mass(6000000, MassUnit.nanoGram), to: Mass(6, MassUnit.milliGram)),
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
        amount: Mass(5, MassUnit.milliGram),
        divisor: MassPerVolume(5, MassUnit.milliGram, VolumeUnit.milliLiters),
        result: Volume.milliLiters(1),
      ),
      (
        amount: Mass(7, MassUnit.microGram),
        divisor: MassPerVolume(
          0.007,
          MassUnit.milliGram,
          VolumeUnit.milliLiters,
        ),
        result: Volume.milliLiters(1),
      ),
      (
        amount: Mass(7, MassUnit.microGram),
        divisor: MassPerVolume(
          0.007,
          MassUnit.milliGram,
          VolumeUnit.milliLiters,
        ),
        result: Volume.milliLiters(1),
      ),
      (
        amount: Mass(60, MassUnit.nanoGram),
        divisor: MassPerVolume(
          0.004,
          MassUnit.microGram,
          VolumeUnit.milliLiters,
        ),
        result: Volume.milliLiters(15),
      ),
      (
        amount: Mass(60000000, MassUnit.nanoGram),
        divisor: MassPerVolume(6, MassUnit.milliGram, VolumeUnit.milliLiters),
        result: Volume.milliLiters(10),
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
      Mass(1, MassUnit.kiloGram),
      Mass(999, MassUnit.gram),
      Mass(1, MassUnit.gram),
      Mass(999, MassUnit.milliGram),
      Mass(1, MassUnit.milliGram),
      Mass(999, MassUnit.microGram),
      Mass(1, MassUnit.microGram),
      Mass(999, MassUnit.nanoGram),
    ];
    for (final currentMass in decreasingMassList) {
      test("test $currentMass >= $currentMass", () {
        expect(currentMass >= currentMass, isTrue);
      });
      test("test $currentMass <= $currentMass", () {
        expect(currentMass <= currentMass, isTrue);
      });
      final largerMasses = decreasingMassList.takeWhile(
        (value) => value != currentMass,
      );
      for (final largerMass in largerMasses) {
        test("hashcode not equal", () {
          expect(currentMass.hashCode, isNot(equals(largerMass.hashCode)));
        });
        test("test $largerMass > $currentMass", () {
          expect(largerMass > currentMass, isTrue);
        });
        test("test $largerMass >= $currentMass", () {
          expect(currentMass >= largerMass, isFalse);
          expect(largerMass >= currentMass, isTrue);
        });
        test("test $largerMass <= $currentMass", () {
          expect(largerMass <= currentMass, isFalse);
          expect(currentMass <= largerMass, isTrue);
        });
        test("test $currentMass < $largerMass", () {
          expect(largerMass < currentMass, isFalse);
          expect(currentMass < largerMass, isTrue);
        });
      }
    }
    const List<MassDivisionTestCase> massDividingTestCases = [
      (
        dividend: Mass.kiloGrams(5),
        divisor: Mass.kiloGrams(5),
        answer: MassPerMass.perKg(1, MassUnit.kiloGram),
      ),
      (
        dividend: Mass.kiloGrams(10),
        divisor: Mass.kiloGrams(5),
        answer: MassPerMass.perKg(2, MassUnit.kiloGram),
      ),
      (
        dividend: Mass.milliGrams(30),
        divisor: Mass.kiloGrams(3),
        answer: MassPerMass.perKg(10, MassUnit.milliGram),
      ),
      (
        dividend: Mass.kiloGrams(30),
        divisor: Mass.milliGrams(3),
        answer: MassPerMass(10, MassUnit.kiloGram, MassUnit.milliGram),
      ),
    ];

    for (final (:dividend, :divisor, :answer) in massDividingTestCases) {
      test("expect $dividend / $divisor == $answer", () {
        expect(dividend.divideMass(divisor), equals(answer));
      });
      test("expect $dividend / $divisor has massUnit ${answer.massUnit}", () {
        expect(dividend.divideMass(divisor).massUnit, equals(answer.massUnit));
      });
      test(
        "expect $dividend / $divisor has perMassUnit ${answer.massUnit}",
        () {
          expect(
            dividend.divideMass(divisor).perMassUnit,
            equals(answer.perMassUnit),
          );
        },
      );
    }
  });
}
