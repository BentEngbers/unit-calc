import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

// ignore: camel_case_types
typedef _testCase = ({VolumePerTime val, TimeUnit unit, String result});
void main() {
  group('VolumePerTime', () {
    test("invalid json", () {
      expect(
        () => VolumePerTime.fromJson("120 ml/hr/kg"),
        throwsInvalidJsonException,
      );
    });
    test("multiply by volumePerTime", () {
      expect(
        const VolumePerTime(3, VolumeUnit.milliLiters, TimeUnit.minute)
            .multiplyWithDilution(
          const MassPerVolume(5, milliGram, VolumeUnit.milliLiters),
        ),
        const MassPerTime(15, milliGram, TimeUnit.minute),
      );
    });
    const List<_testCase> testCases = [
      (
        val: VolumePerTime(
          2,
          VolumeUnit.milliLiters,
          TimeUnit.minute,
        ),
        unit: TimeUnit.hour,
        result: "120 ml/hr"
      ),
      (
        val: VolumePerTime(
          60,
          VolumeUnit.milliLiters,
          TimeUnit.hour,
        ),
        unit: TimeUnit.minute,
        result: "1 ml/min"
      ),
    ];
    for (final (:val, :unit, :result) in testCases) {
      test("json roundTrip", () {
        expect(VolumePerTime.fromJson(val.toJson()), val);
      });
      test("hashCode", () {
        expect(val.hashCode, isNot(VolumePerTime.fromJson(result).hashCode));
      });
      test("test time conversion", () {
        expect(
          val.asNumber(VolumeUnit.milliLiters, unit),
          VolumePerTime.fromJson(result).asNumber(),
        );
      });
    }
    test("test time conversion", () {
      const volumePerTime = VolumePerTime(
        2,
        VolumeUnit.milliLiters,
        TimeUnit.minute,
      );
      expect(volumePerTime.as(VolumeUnit.milliLiters, TimeUnit.hour).toString(),
          "120 ml/hr",);
    });
    test("test time conversion", () {
      const volumePerTime = VolumePerTime(
        10,
        VolumeUnit.milliLiters,
        TimeUnit.hour,
      );
      expect(
        volumePerTime.as(VolumeUnit.milliLiters, TimeUnit.hour).toString(),
        "10 ml/hr",
      );
    });
  });
}
