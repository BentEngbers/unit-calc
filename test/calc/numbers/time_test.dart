import 'package:test/test.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

typedef UnitConversion = ({Time from, Time to});

void main() {
  group("Time", () {
    test("bad json test", () {
      expect(() => Time.fromJson("FOO"), throwsFormatException);
    });
    test("bad json test", () {
      expect(() => Time.fromJson("3.2 mg/ml"), throwsFormatException);
    });
    test(
      "throws an error if initialized with negative number",
      () {
        expect(() => const Time.seconds(-1), throwAssertionError);
      },
      skip: "This functionality has temporarily been removed.",
    );
    test("check the to string method", () {
      expect(const Time.seconds(2.1).toString(), "2.1 seconds");
    });
    test(
      "equality different TimeUnit",
      () => {expect(const Time.seconds(60) == const Time.minutes(1), true)},
    );
    test(
      "equality different TimeUnit non-integral value",
      () => {expect(const Time.seconds(45) == const Time.minutes(0.75), true)},
    );
    test(
      "equality different value",
      () => {expect(const Time.seconds(5) == const Time.seconds(6), false)},
    );
    test(
      "equality true",
      () => {expect(const Time.hour(6) == const Time.hour(6), true)},
    );
    const cases = <UnitConversion>[
      (from: Time.seconds(5), to: Time.minutes(5 / 60)),
      (from: Time.seconds(7), to: Time(7 / 3600, TimeUnit.hr)),
      (from: Time.minutes(9), to: Time.seconds(9 * 60)),
      (from: Time.minutes(11), to: Time.hour(11 / 60)),
      (from: Time.hour(1), to: Time.seconds(3600)),
      (from: Time.hour(2), to: Time.minutes(120)),
    ];

    for (final testCase in cases) {
      final (:from, :to) = testCase;
      test("Test convertTo from $from to ${to.unit.displayName}", () {
        expect(from.as(from.unit), to);
      });
      test("json roundtrip", () {
        expect(Time.fromJson(from.toJson()), equals(from));
      });
    }

    const decreasingTimeList = [
      Time.hour(1),
      Time.minutes(59.9),
      Time.seconds(3500),
      Time.seconds(999),
      Time.minutes(12),
      Time.hour(1 / 10),
      Time.seconds(10),
      Time.minutes(1 / 10)
    ];
    for (final currentTime in decreasingTimeList) {
      test("test $currentTime >= $currentTime", () {
        expect(currentTime >= currentTime, isTrue);
      });
      final elementsBefore =
          decreasingTimeList.takeWhile((value) => value != currentTime);
      for (final massBefore in elementsBefore) {
        test("hashcode not equal", () {
          expect(currentTime.hashCode, isNot(equals(massBefore.hashCode)));
        });
        test("test $massBefore > $currentTime", () {
          expect(massBefore > currentTime, isTrue);
        });
        test("test $massBefore >= $currentTime", () {
          expect(currentTime >= massBefore, isFalse);
          expect(massBefore >= currentTime, isTrue);
        });
        test("test $currentTime < $massBefore", () {
          expect(massBefore < currentTime, isFalse);
          expect(currentTime < massBefore, isTrue);
        });
      }
    }
  });
}
