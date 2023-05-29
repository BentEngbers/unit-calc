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

void main() {
  group('Volume', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Volume(-1),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("throws error when result is negative", () {
      expect(() => {Volume(1) - SyringeSizes.ML10.volume},
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check addition", () {
      var a = Volume(1) + SyringeSizes.ML10.volume;
      expect(a, Volume(11));
    });
    test("check equality", () {
      expect(Mass(5), isNot(Volume(5)));
    });
    test("check the tostring method", () {
      expect(Volume(10).toString(), "10 ml");
    });
    test("check the tostring method", () {
      expect(Volume(10.14).toString(), "10.1 ml");
    });
    test("check the toFixedDecimalString method", () {
      expect(Volume(10).toFixedDecimalString(minDigit: 2, maxDigit: 2),
          "10.00 ml");
    });
    test("check the toFixedDecimalString method", () {
      expect(Volume(5.5).toFixedDecimalString(maxDigit: 0), "6 ml");
    });
    test("test equals", () {
      expect(Volume(1), Volume(1));
    });
  });
}
