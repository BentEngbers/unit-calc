import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

typedef UnitTestCases = ({
  ConcentrationUnit unit,
  String name,
  double factorToMG
});
void main() {
  group('ConcentrationUnit', () {
    test("U equals", () {
      expect(const U(factorToMG: 4), const U(factorToMG: 4));
    });
    test("U notEquals", () {
      expect(const U(factorToMG: 4), isNot(const U(factorToMG: 5)));
    });
    const testCases = <UnitTestCases>[
      (unit: mg, name: "mg", factorToMG: 1),
      (unit: mcg, name: "mcg", factorToMG: 0.001),
      (unit: nanoGr, name: "nanogr", factorToMG: 0.000001),
      (unit: U(factorToMG: 1.0), name: "U", factorToMG: 1.0),
    ];
    for (final tuple in testCases) {
      test("test name of ${tuple.unit}", () {
        expect(tuple.unit.name, tuple.name);
      });
      test("test factorMG of ${tuple.unit}", () {
        expect(tuple.unit.factorToMG, tuple.factorToMG);
      });
      test("test factorMG of ${tuple.unit}", () {
        expect(ConcentrationUnit.fromJson(tuple.name), equals(tuple.unit));
      });
    }
    test(
        "throws an error if trying to create a ConcentraionUnit from an invalid string",
        () {
      expect(() => ConcentrationUnit.fromJson("FOO"), throwsException);
    });
  });
}