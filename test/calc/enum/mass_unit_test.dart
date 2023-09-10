import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/unit_calc.dart';

typedef _UnitTestCases = ({MassUnit unit, String name, int factorNanoGr});
typedef _MassUnitConversionTestCase = ({
  MassUnit unit1,
  MassUnit unit2,
  num convertFactor,
});
void main() {
  group('MassUnit', () {
    test("U equals", () {
      expect(const U(factorToNg: 4), const U(factorToNg: 4));
    });
    test("U notEquals", () {
      expect(const U(factorToNg: 4), isNot(const U(factorToNg: 5)));
    });

    const testCases = <_UnitTestCases>[
      (unit: MassUnit.kiloGram, name: "kg", factorNanoGr: 1000000000000),
      (unit: MassUnit.gram, name: "g", factorNanoGr: 1000000000),
      (unit: MassUnit.milliGram, name: "mg", factorNanoGr: 1000000),
      (unit: MassUnit.microGram, name: "mcg", factorNanoGr: 1000),
      (unit: MassUnit.nanoGram, name: "nanogr", factorNanoGr: 1),
      (unit: U(factorToNg: 11), name: "U(factorNanoGr: 11)", factorNanoGr: 11),
    ];
    for (final (:unit, :name, :factorNanoGr) in testCases) {
      group("$name:", () {
        test("json roundtrip", () {
          expect(MassUnit.fromJson(unit.toJson()), unit);
        });
        test("test name", () {
          expect(unit.displayName, name.split("(")[0]);
        });
        test("test factorNanoGr", () {
          expect(unit.factorNanoGr, factorNanoGr);
        });

        test("hashcode", () {
          expect(unit.hashCode, Object.hash(name.split("(")[0], factorNanoGr));
        });
      });
    }
    test(
        "throws an error if trying to create a ConcentrationUnit from an invalid string",
        () {
      expect(
        () => MassUnit.fromJson("FOO"),
        throwsA(
          predicate(
            (x) =>
                x is InvalidMassUnitException &&
                x.toString() ==
                    "InvalidMassUnitException: The given string was an invalid MassUnit",
          ),
        ),
      );
    });
  });
  const unitTests = <_MassUnitConversionTestCase>[
    (unit1: MassUnit.milliGram, unit2: MassUnit.milliGram, convertFactor: 1.0),
    (
      unit1: MassUnit.milliGram,
      unit2: MassUnit.microGram,
      convertFactor: 1000.0
    ),
    (
      unit1: MassUnit.microGram,
      unit2: MassUnit.nanoGram,
      convertFactor: 1000.0
    ),
    (unit1: MassUnit.nanoGram, unit2: MassUnit.microGram, convertFactor: 0.001),
    (unit1: U(factorToNg: 1), unit2: U(factorToNg: 1), convertFactor: 1),
  ];
  for (final (:unit1, :unit2, :convertFactor) in unitTests) {
    test("test conversion from $unit1 to $unit2", () {
      expect(unit1.convertFactor(to: unit2), convertFactor);
    });
  }
}
