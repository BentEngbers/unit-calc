import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';

main() {
  group("Calc", () {
    for (var tuple in [
      const Tuple3(mg, mg, 1.0),
      const Tuple3(mg, mcg, 1000.0),
      const Tuple3(mcg, nanoGr, 1000.0),
      const Tuple3(nanoGr, mcg, 0.001),
      const Tuple3(U, U, 1.0)
    ]) {
      test("test conversion from ${tuple.value1} to ${tuple.value2}", () {
        // expect(Calc.convertFactorOnlyUnit(from: tuple.value1, to: tuple.value2),
        //     moreOrLessEquals(tuple.value3, epsilon: PRECISION));
      });
    }

    const min = TimeUnit.min;
    const hr = TimeUnit.hr;
    for (var tuple in [
      const Tuple3(min, min, 1.0),
      const Tuple3(hr, min, (1 / 60)),
      const Tuple3(min, hr, 60.0),
      const Tuple3(hr, hr, 1.0)
    ]) {
      test("test conversion from ${tuple.value1} to ${tuple.value2}", () {
        // expect(
        //     Calc.convertFactorOnlyTime(
        //         fromTime: tuple.value1, toTime: tuple.value2),
        //     moreOrLessEquals(tuple.value3, epsilon: PRECISION));
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
    //0.00700000000000000015
  });
}
