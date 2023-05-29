import 'package:dartz/dartz.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/SyringeSizes.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerKGTime.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerML.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerMLKG.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerMLTime.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerTime.dart';
import 'package:unit_calc/src/calc/numbers/Mass.dart';
import 'package:unit_calc/src/calc/numbers/Volume.dart';
import 'package:unit_calc/src/calc/numbers/VolumePerTime.dart';

void main() {
  group('ConcentrationUnit', () {
    test("U equals", () {
      expect(const ConcentrationUnit.U(4), const ConcentrationUnit.U(4));
    });
    test("U notEquals", () {
      expect(const ConcentrationUnit.U(4), isNot(const ConcentrationUnit.U(5)));
    });
    for (var tuple in [
      const Tuple3(mg, "mg", 1),
      const Tuple3(mcg, "mcg", 0.001),
      const Tuple3(nanogr, "nanogr", 0.000001),
      const Tuple3(U, "U", 1.0)
    ]) {
      test("test name of ${tuple.value1}", () {
        expect(tuple.value1.name, tuple.value2);
      });
      test("test factorMG of ${tuple.value1}", () {
        expect(tuple.value1.factorMG, tuple.value3);
      });
      test("test factorMG of ${tuple.value1}", () {
        expect(ConcentrationUnit.fromJson(tuple.value2), tuple.value1);
      });
    }
    test(
        "throws an error if trying to create a ConcentraionUnit from an invalid string",
        () {
      expect(() => ConcentrationUnit.fromJson("FOO"), throwsException);
    });
  });
}
