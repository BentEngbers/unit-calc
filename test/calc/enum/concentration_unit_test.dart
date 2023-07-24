import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

typedef UnitTestCases = ({MassUnit unit, String name, int factorNanoGr});
void main() {
  group('MassUnit', () {
    test("U equals", () {
      expect(const U(factorToNg: 4), const U(factorToNg: 4));
    });
    test("U notEquals", () {
      expect(const U(factorToNg: 4), isNot(const U(factorToNg: 5)));
    });
    const testCases = <UnitTestCases>[
      (unit: milliGram, name: "mg", factorNanoGr: 1000000),
      (unit: microGram, name: "mcg", factorNanoGr: 1000),
      (unit: nanoGram, name: "nanogr", factorNanoGr: 1),
      (unit: U(factorToNg: 1.0), name: "U", factorNanoGr: 1),
    ];
    for (final tuple in testCases) {
      test("test name of ${tuple.unit}", () {
        expect(tuple.unit.displayName, tuple.name);
      });
      test("test factorMG of ${tuple.unit}", () {
        expect(tuple.unit.factorNanoGr, tuple.factorNanoGr);
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
