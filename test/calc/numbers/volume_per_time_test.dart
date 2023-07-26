import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/volume_per_time.dart';

typedef testCase = ({VolumePerTime val, TimeUnit unit, String result});
void main() {
  group('VolumePerTime', () {
    test("invalid json", () {
      expect(
          () => VolumePerTime.fromJson("120 ml/hr/kg"), throwsFormatException);
    });
    const List<testCase> testCases = [
      (
        val: VolumePerTime(
          2,
          VolumeUnit.ml,
          TimeUnit.min,
        ),
        unit: TimeUnit.hr,
        result: "120 ml/hr"
      ),
      (
        val: VolumePerTime(
          60,
          VolumeUnit.ml,
          TimeUnit.hr,
        ),
        unit: TimeUnit.min,
        result: "1 ml/min"
      )
    ];
    for (final (:val, :unit, :result) in testCases) {
      test("json roundTrip", () {
        expect(VolumePerTime.fromJson(val.toJson()), val);
      });
      test("hashCode", () {
        expect(val.hashCode, isNot(VolumePerTime.fromJson(result).hashCode));
      });
      test("test time conversion", () {
        expect(val.as(timeUnit: TimeUnit.hr), VolumePerTime.fromJson(result));
      });
    }
    test("test time conversion", () {
      final volumePerTime = VolumePerTime(
        2,
        VolumeUnit.ml,
        TimeUnit.min,
      );
      expect(volumePerTime.as(timeUnit: TimeUnit.hr).toString(), "120 ml/hr");
    });
    test("test time conversion", () {
      final volumePerTime = VolumePerTime(
        10,
        VolumeUnit.ml,
        TimeUnit.hr,
      );
      expect(volumePerTime.as(timeUnit: TimeUnit.hr).toString(), "10 ml/hr");
    });
  });
}
