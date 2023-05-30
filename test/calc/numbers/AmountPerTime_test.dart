import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/Exceptions.dart';
import 'package:unit_calc/src/calc/enum/ConcentrationUnit.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerKGTime.dart';
import 'package:unit_calc/src/calc/numbers/AmountPerTime.dart';

void main() {
  group('AmountPerKGTime', () {
    test("throws an error if initialized with negative number", () {
      expect(() => AmountPerTime(-6, mcg, TimeUnit.hr),
          throwsA(const TypeMatcher<NegativeNumberException>()));
    });
    test("check the to string method", () {
      expect(
          '${AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.hr)}', "2.4 U/hr");
    });
    test("equality true", () {
      expect(
          AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.hr) ==
              AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.hr),
          true);
    });
    test("equality different value", () {
      expect(
          AmountPerTime(2.5, U(factorToMG: 1), TimeUnit.hr) ==
              AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.hr),
          false);
    });
    test("equality different unit", () {
      expect(
          AmountPerTime(2.4, mcg, TimeUnit.hr) ==
              AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.hr),
          false);
    });
    test("equality different time unit", () {
      expect(
          AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.min) ==
              AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.hr),
          false);
    });
    test("equality different class", () {
      expect(
          AmountPerTime(2.4, U(factorToMG: 1), TimeUnit.min) ==
              AmountPerKGTime(2.4, U(factorToMG: 1), TimeUnit.min),
          false);
    });
    test("equality different unit Time", () {
      expect(
          AmountPerTime(5, U(factorToMG: 1), TimeUnit.hr) ==
              AmountPerKGTime(60, U(factorToMG: 1), TimeUnit.min),
          false);
    });
    test("equality different unit Time", () {
      expect(
          AmountPerTime(60, U(factorToMG: 1), TimeUnit.min) ==
              AmountPerKGTime(5, U(factorToMG: 1), TimeUnit.hr),
          false);
    });
    test("equality different ConcentrationUnit and time unit", () {
      expect(
          AmountPerTime(60, mg, TimeUnit.min) ==
              AmountPerKGTime(5000, mcg, TimeUnit.hr),
          false);
    });
  });
}
