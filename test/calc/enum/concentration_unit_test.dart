import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

typedef UnitTestCases = ({MassUnit unit, String name, double factorToMG});
void main() {
  group('MassUnit', () {
    test("U equals", () {
      expect(const U(factorToNg: 4), const U(factorToNg: 4));
    });
    test("U notEquals", () {
      expect(const U(factorToNg: 4), isNot(const U(factorToNg: 5)));
    });
    const testCases = <UnitTestCases>[
      (unit: milliGram, name: "mg", factorToMG: 1),
      (unit: microGram, name: "mcg", factorToMG: 0.001),
      (unit: nanoGram, name: "nanogr", factorToMG: 0.000001),
      (unit: U(factorToNg: 1.0), name: "U", factorToMG: 1.0),
    ];
    for (final tuple in testCases) {
      test("test name of ${tuple.unit}", () {
        expect(tuple.unit.name, tuple.name);
      });
      test("test factorMG of ${tuple.unit}", () {
        expect(tuple.unit.factorNanoGr, tuple.factorToMG);
      });
      test("test factorMG of ${tuple.unit}", () {
        expect(MassUnit.fromJson(tuple.name), equals(tuple.unit));
      });
    }
    test(
        "throws an error if trying to create a ConcentrationUnit from an invalid string",
        () {
      expect(() => MassUnit.fromJson("FOO"), throwsException);
    });
  });
}
