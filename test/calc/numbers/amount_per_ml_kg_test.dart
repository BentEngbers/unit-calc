import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml_kg.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';

typedef testCase = ({double amountPerMlKg, double mass, double result});
void main() {
  group('AmountPerMLKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerMLKG(-4, mcg), throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${AmountPerMLKG(0.0, mcg)}', "0 mcg/ml/kg");
    });
    const testCases = <testCase>[
      (amountPerMlKg: 5.0, mass: 6.0, result: 30.0),
      (amountPerMlKg: 0.0, mass: 5.0, result: 0.0),
      (amountPerMlKg: 1.0, mass: 4.0, result: 4.0),
    ];
    for (final testCase in testCases) {
      final (:amountPerMlKg, :mass, :result) = testCase;
      test("mass multiplication", () {
        expect(AmountPerMLKG(amountPerMlKg, U(factorToMG: 1)) * Mass(mass),
            equals(AmountPerML(result, U(factorToMG: 1))));
      });
    }
  });
}
