import 'package:test/test.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';

typedef UnitConversionTestCase = ({
  ConcentrationUnit unit1,
  ConcentrationUnit unit2,
  double value,
});
typedef TimeUnitConversionTestCase = ({
  TimeUnit unit1,
  TimeUnit unit2,
  double value,
});
main() {
  group("Calc", () {
    const unitTests = <UnitConversionTestCase>[
      (unit1: mg, unit2: mg, value: 1.0),
      (unit1: mg, unit2: mcg, value: 1000.0),
      (unit1: mcg, unit2: nanoGr, value: 1000.0),
      (unit1: nanoGr, unit2: mcg, value: 0.001),
      (unit1: U(factorToMG: 1), unit2: U(factorToMG: 1), value: 1),
    ];
    for (final tuple in unitTests) {
      test("test conversion from ${tuple.unit1} to ${tuple.unit2}", () {
        expect(Calc.convertFactorOnlyUnit(from: tuple.unit1, to: tuple.unit2),
            closeTo(tuple.value, defaultPrecision));
      });
    }

    const min = TimeUnit.min;
    const hr = TimeUnit.hr;
    const timeTests = <TimeUnitConversionTestCase>[
      (unit1: min, unit2: min, value: 1.0),
      (unit1: hr, unit2: min, value: 1 / 60),
      (unit1: min, unit2: hr, value: 60),
      (unit1: hr, unit2: hr, value: 1.0),
    ];
    for (final tuple in timeTests) {
      test("test conversion from ${tuple.unit1} to ${tuple.unit2}", () {
        expect(
            Calc.convertFactorOnlyTime(
                fromTime: tuple.unit1, toTime: tuple.unit2),
            closeTo(tuple.value, defaultPrecision));
      });
    }
    test("doubleEquals", () {
      expect(Calc.doubleEquals(4, 4), true);
    });
    test("doubleEquals  false", () {
      expect(Calc.doubleEquals(4, 5), false);
    });
    test("doubleEquals on precision", () {
      expect(Calc.doubleEquals(4, 4.0000000001), false);
    });
    test("doubleEquals smaller than precision", () {
      expect(Calc.doubleEquals(4, 4.00000000001), true);
    });
    test("doubleEquals larger than precision ", () {
      expect(Calc.doubleEquals(4, 4.000000001), false);
    });
    test("doubleEquals larger than precision ", () {
      expect(Calc.doubleEquals(0.007, 0.007), true);
    });
  });
}
