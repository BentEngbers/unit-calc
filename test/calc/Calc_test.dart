import 'package:test/test.dart';
import 'package:unit_calc/src/calc/Calc.dart';

main() {
  group("Calc", () {
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
