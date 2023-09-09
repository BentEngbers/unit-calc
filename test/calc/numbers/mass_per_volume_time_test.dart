import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume_time.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('AmountPerMLTime', () {
    test("throws an error if initialized with negative number", () {
      expect(
        () => MassPerVolumeTime(
            -4, microGram, VolumeUnit.milliLiters, TimeUnit.hour),
        throwsAssertionError,
      );
    });
    test("check the to string method", () {
      expect(
        '${const MassPerVolumeTime(1.2, U(factorToNg: 1), VolumeUnit.milliLiters, TimeUnit.minute)}',
        "1.2 U/ml/min",
      );
    });
    test("json round trips", () {
      const massPerVolumeTime = MassPerVolumeTime(
          1.2, U(factorToNg: 1), VolumeUnit.milliLiters, TimeUnit.minute);
      expect(
        MassPerVolumeTime.fromJson(massPerVolumeTime.toJson()),
        massPerVolumeTime,
      );
    });
    test("hashCode", () {
      const massPerVolumeTime = MassPerVolumeTime(
          1.2, U(factorToNg: 1), VolumeUnit.milliLiters, TimeUnit.minute);
      const massPerVolumeTime2 = MassPerVolumeTime(
          1.2, U(factorToNg: 1), VolumeUnit.milliLiters, TimeUnit.hour);
      expect(massPerVolumeTime.hashCode, isNot(massPerVolumeTime2.hashCode));
    });
    const List<MassPerVolumeTime> decreasingMassPerVolumeTime = [
      MassPerVolumeTime(5, gram, VolumeUnit.milliLiters, TimeUnit.hour),
      MassPerVolumeTime(5, gram, VolumeUnit.milliLiters, TimeUnit.minute),
      MassPerVolumeTime(5, milliGram, VolumeUnit.milliLiters, TimeUnit.minute)
    ];
    for (final current in decreasingMassPerVolumeTime) {
      final previousValues =
          decreasingMassPerVolumeTime.takeWhile((value) => value != current);
      for (final previous in previousValues) {
        test("$previous > $current", () {
          expect(previous > current, isTrue);
        });
        test("$previous >= $current", () {
          expect(previous >= current, isTrue);
        });
      }
    }
    test("wrong json", () {
      expect(
        () => MassPerVolumeTime.fromJson("5 mg/ml"),
        throwsInvalidJsonException,
      );
    });
  });
}
