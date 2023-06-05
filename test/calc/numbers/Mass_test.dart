import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';

void main() {
  group('Mass', () {
    test("throws an error if initialized with negative Mass", () {
      expect(() => Mass(-1), throwsA(isA<AssertionError>()));
    });
    test("check the toFixedDecimalString method same minDigit as maxDigit", () {
      expect(Mass(2).toDisplayString((minDigit: 2, maxDigit: 2)), "2.00 kg");
    });
    test("check the toFixedDecimalString method maxDigit=1 overrides minDigit",
        () {
      expect(Mass(2).toDisplayString((minDigit: 2, maxDigit: 1)), "2.0 kg");
    });
    test("check the toFixedDecimalString method default value", () {
      expect(Mass(10).toDisplayString((minDigit: 1, maxDigit: 1)), "10.0 kg");
    });
    test("check the toFixedDecimalString method extra zeros", () {
      expect(Mass(10).toDisplayString((minDigit: 2, maxDigit: 2)), "10.00 kg");
    });
    test("check the toFixedDecimalString method rounding", () {
      expect(Mass(5.5).toDisplayString((minDigit: 0, maxDigit: 0)), "6 kg");
    });

    test("check the tostring method stringinterpolation", () {
      var a = Mass(10.1);
      expect("$a", "10.1 kg");
    });
    // test("check isAbsoluteZero true", () {
    //   expect(Mass(0).isAbsoluteZero, isTrue);
    // });
    // test("check isAbsoluteZero false", () {
    //   expect(Mass(0.0000001).isAbsoluteZero, isFalse);
    // });
    // test("check isZero false", () {
    //   const value = defaultPrecision * 10;
    //   expect(Mass(value).isZero, isFalse);
    // });
    // test("check isZero true", () {
    //   const value = defaultPrecision / 10;
    //   expect(Mass(value).isZero, isTrue);
    // });

    test("check < operator false", () {
      expect(Mass(5) < Mass(4), isFalse);
    });
    test("check < operator true", () {
      expect((Mass(3.9999999999) < Mass(4)), true);
    });
    test("check <= operator true", () {
      expect(Mass(5) <= Mass(5), true);
    });
    test("check <= operator true", () {
      expect((Mass(3.9999999999) <= Mass(4)), true);
    });
    test("check <= operator false", () {
      expect((Mass(4) <= Mass(3.9999999999)), false);
    });
  });
}
