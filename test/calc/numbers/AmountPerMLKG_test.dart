import 'package:dartz/dartz.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_ml_kg.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';

void main() {
  group('AmountPerMLKG', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerMLKG(-4, mcg),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check the to string method", () {
      expect('${AmountPerMLKG(0.0, mcg)}', "0 mcg/ml/kg");
    });

    for (var v in [
      const Tuple3(5.0, 6.0, 30.0),
      const Tuple3(0.0, 5.0, 0.0),
      const Tuple3(1.0, 4.0, 4.0)
    ]) {
      test("mass multiplication", () {
        expect(AmountPerMLKG(v.value1, U(factorToMG: 1)) * Mass(v.value2),
            AmountPerML(v.value3, U(factorToMG: 1)));
      });
    }
  });
}
