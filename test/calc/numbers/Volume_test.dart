import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/syringe_sizes.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/volume.dart';

void main() {
  group('Volume:', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Volume.ml(-1), throwsA(isA<AssertionError>()));
    });
    test("throws error when result is negative", () {
      expect(() => {Volume.ml(1) - SyringeSizes.ml20.volume},
          throwsA(isA<AssertionError>()));
    });
    test("check addition", () {
      final a = Volume.ml(1) + SyringeSizes.ml10.volume;
      expect(a, Volume.ml(11));
    });
    test("check equality", () {
      expect(Mass.kiloGram(5), isNot(Volume.ml(5)));
    });
    test("check the tostring method", () {
      expect(Volume.ml(10).toString(), "10 ml");
    });
    test("check the tostring method", () {
      expect(Volume.ml(10.14).toString(), "10.1 ml");
    });
    test("check the toFixedDecimalString method", () {
      expect(Volume.ml(10).toDisplayString((minDigit: 2, maxDigit: 2)),
          "10.00 ml");
    });
    test("check the toFixedDecimalString method", () {
      expect(
          Volume.ml(5.5).toDisplayString((minDigit: 0, maxDigit: 0)), "6 ml");
    });
    test("test equals", () {
      expect(Volume.ml(1), Volume.ml(1));
    });
  });
}
