import 'package:test/test.dart';
import 'package:unit_calc/src/calc/numbers/time.dart';

typedef TestCase = ({Time time, String result});

final List<TestCase> tests = [
  (time: const Time.zero(), result: "00:00:00"),
  (time: const Time.minutes(10), result: "00:10:00"),
  (time: const Time.minutes(9), result: "00:09:00"),
  (time: const Time.minutes(61), result: "01:01:00"),
  (time: const Time.minutes(61), result: "01:01:00"),
  (time: const Time.seconds(8274), result: "02:17:54"),
  (time: const Time.seconds(214367), result: "59:32:47")
];
final List<TestCase> testsShort = [
  (time: const Time.zero(), result: "00:00"),
  (time: const Time.minutes(10), result: "10:00"),
  (time: const Time.hours(1), result: "01:00:00"),
  (time: const Time.minutes(9), result: "09:00"),
  (time: const Time.minutes(61), result: "01:01:00"),
  (time: const Time.minutes(61), result: "01:01:00"),
  (time: const Time.seconds(8274), result: "02:17:54"),
  (time: const Time.seconds(214367), result: "59:32:47")
];
main() {
  for (final testCase in tests) {
    test("asHHmmSS for a concentrationPoint with time ${testCase.time}", () {
      expect(testCase.time.asHHmmSS, testCase.result);
    });
  }
  for (final testCase in testsShort) {
    test("hh_mm_ss for a concentrationPoint with time ${testCase.time}", () {
      expect(testCase.time.asHHmmSS_short, testCase.result);
    });
  }
}
