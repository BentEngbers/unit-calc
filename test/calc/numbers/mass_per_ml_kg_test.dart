import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume_mass.dart';

typedef testCase = ({double amountPerMlKg, double mass, double result});
void main() {
  group('AmountPerMLKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerVolumeMass(-4, microGram, VolumeUnit.ml),
          throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${AmountPerVolumeMass(0.0, microGram, VolumeUnit.ml)}',
          "0 mcg/ml/kg");
    });
    const testCases = <testCase>[
      (amountPerMlKg: 5.0, mass: 6.0, result: 30.0),
      (amountPerMlKg: 0.0, mass: 5.0, result: 0.0),
      (amountPerMlKg: 1.0, mass: 4.0, result: 4.0),
    ];
    for (final testCase in testCases) {
      final (:amountPerMlKg, :mass, :result) = testCase;
      test("mass multiplication", () {
        expect(
            AmountPerVolumeMass(
                    amountPerMlKg, U(factorToNg: 1), VolumeUnit.ml) *
                Mass(mass, U(factorToNg: 1)),
            equals(
              MassPerVolume(result, U(factorToNg: 1), VolumeUnit.ml),
            ));
      });
    }
  });
}
