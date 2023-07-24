import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume_time.dart';

void main() {
  group('AmountPerMLTime', () {
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerVolumeTime(-4, microGram, VolumeUnit.ml, TimeUnit.hr),
          throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect(
          '${MassPerVolumeTime(1.2, U(factorToNg: 1), VolumeUnit.ml, TimeUnit.min)}',
          "1.2 U/ml/min");
    });
  });
}
