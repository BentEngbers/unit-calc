import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/Volume.dart';

typedef UnitConversion = ({Mass from, Mass to});
typedef UnitConversionDivision = ({
  Mass amount,
  MassPerVolume divisor,
  Volume result,
});
void main() {
  group('Amount:', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Mass(-1, microGram), throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect(Mass(2.1, milliGram).toString(), "2.1 mg");
    });
    test("equality different MassUnit",
        () => {expect(Mass(5, microGram) == Mass(5, milliGram), false)});
    test("equality different value",
        () => {expect(Mass(5, milliGram) == Mass(6, milliGram), false)});
    test("equality true",
        () => {expect(Mass(6, milliGram) == Mass(6, milliGram), true)});
    const cases = <UnitConversion>[
      (from: Mass(5, milliGram), to: Mass(5, milliGram)),
      (from: Mass(7, microGram), to: Mass(0.007, milliGram)),
      (from: Mass(9, nanoGram), to: Mass(0.009, microGram)),
      (from: Mass(6000000, nanoGram), to: Mass(6, milliGram))
    ];
    for (final testCase in cases) {
      final (:from, :to) = testCase;
      test("Test convertTo from $from to ${to.unit.name}", () {
        expect(from.as(from.unit), to);
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
      test("Test dividing $amount by $divisor",
          () => {expect(amount / divisor, equals(result))});
    }
  });
}
