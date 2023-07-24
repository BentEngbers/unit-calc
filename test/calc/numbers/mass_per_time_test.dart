import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_time.dart';

void main() {
  group('AmountPerKGTime', () {
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerTime(-6, microGram, TimeUnit.hr),
          throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr)}', "2.4 U/hr");
    });
    test("equality true", () {
      expect(
          MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          true);
    });
    test("equality different value", () {
      expect(
          MassPerTime(2.5, U(factorToNg: 1), TimeUnit.hr) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different unit", () {
      expect(
          MassPerTime(2.4, microGram, TimeUnit.hr) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different time unit", () {
      expect(
          MassPerTime(2.4, U(factorToNg: 1), TimeUnit.min) ==
              MassPerTime(2.4, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different class", () {
      expect(
          // ignore: unrelated_type_equality_checks
          MassPerTime(2.4, U(factorToNg: 1), TimeUnit.min) ==
              Mass(
                2.4,
                U(factorToNg: 1),
              ),
          false);
    });
    test("equality different unit Time", () {
      expect(
          MassPerTime(5, U(factorToNg: 1), TimeUnit.hr) ==
              MassPerTime(60, U(factorToNg: 1), TimeUnit.min),
          false);
    });
    test("equality different unit Time", () {
      expect(
          MassPerTime(60, U(factorToNg: 1), TimeUnit.min) ==
              MassPerTime(5, U(factorToNg: 1), TimeUnit.hr),
          false);
    });
    test("equality different MassUnit and time unit", () {
      expect(
          MassPerTime(60, milliGram, TimeUnit.min) ==
              MassPerTime(5000, microGram, TimeUnit.hr),
          false);
    });
  });
}
