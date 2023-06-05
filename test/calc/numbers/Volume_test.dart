import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/syringe_sizes.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/volume.dart';

void main() {
  group('Volume:', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Volume(-1), throwsA(isA<AssertionError>()));
    });
    test("throws error when result is negative", () {
      expect(() => {Volume(1) - SyringeSizes.ml20.volume},
          throwsA(isA<AssertionError>()));
    });
    test("check addition", () {
      final a = Volume(1) + SyringeSizes.ml10.volume;
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
      expect(
          Volume(10).toDisplayString((minDigit: 2, maxDigit: 2)), "10.00 ml");
    });
    test("check the toFixedDecimalString method", () {
      expect(Volume(5.5).toDisplayString((minDigit: 0, maxDigit: 0)), "6 ml");
    });
    test("test equals", () {
      expect(Volume(1), Volume(1));
    });
  });
}
