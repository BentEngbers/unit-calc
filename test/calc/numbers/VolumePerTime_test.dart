import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/VolumePerTime.dart';

void main() {
  group('VolumePerTime', () {
    test("test time conversion", () {
      final volumePerTime = VolumePerTime(2, TimeUnit.min);
      expect(volumePerTime.toTimeUnit(TimeUnit.hr).toString(), "120 ml/hr");
    });
    test("test time conversion", () {
      final volumePerTime = VolumePerTime(10, TimeUnit.hr);
      expect(volumePerTime.toTimeUnit(TimeUnit.hr).toString(), "10 ml/hr");
    });
  });
}
