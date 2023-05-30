import 'package:dartz/dartz.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

void main() {
  group('ConcentrationUnit', () {
    test("U equals", () {
      expect(const U(factorToMG: 4), const U(factorToMG: 4));
    });
    test("U notEquals", () {
      expect(const U(factorToMG: 4), isNot(const U(factorToMG: 5)));
    });
    for (final tuple in [
      const Tuple3<ConcentrationUnit, String, double>(mg, "mg", 1),
      const Tuple3<ConcentrationUnit, String, double>(mcg, "mcg", 0.001),
      const Tuple3<ConcentrationUnit, String, double>(
          nanoGr, "nanogr", 0.000001),
      const Tuple3<ConcentrationUnit, String, double>(
          U(factorToMG: 1.0), "U", 1.0)
    ]) {
      test("test name of ${tuple.value1}", () {
        expect(tuple.value1.name, tuple.value2);
      });
      test("test factorMG of ${tuple.value1}", () {
        expect(tuple.value1.factorToMG, tuple.value3);
      });
      test("test factorMG of ${tuple.value1}", () {
        expect(ConcentrationUnit.fromJson(tuple.value2), equals(tuple.value1));
      });
    }
    test(
        "throws an error if trying to create a ConcentraionUnit from an invalid string",
        () {
      expect(() => ConcentrationUnit.fromJson("FOO"), throwsException);
    });
  });
}
