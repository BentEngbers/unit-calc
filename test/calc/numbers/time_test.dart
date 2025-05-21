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
      expect(() => Time.fromJson("3.2 mg/ml"), throwsInvalidJsonException);
    });
    test("seconds: throws an error if initialized with negative number", () {
      expect(() => Time.seconds(-1), throwsAssertionError);
    });
    test("hour: throws an error if initialized with negative number", () {
      expect(() => Time.hours(-1000), throwsAssertionError);
    });
    test("minutes: throws an error if initialized with negative number", () {
      expect(() => Time.minutes(-1000), throwsAssertionError);
    });
    test("check the to string method", () {
      expect(const Time.seconds(2.1).toString(), "2.1 sec");
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
      () => {expect(const Time.hours(6) == const Time.hours(6), true)},
    );
    test("subtraction", () {
      expect(
        const Time.hours(2) - const Time.minutes(10),
        const Time.minutes(110),
      );
    });
    test("addition", () {
      expect(
        const Time.minutes(2) + const Time.seconds(10),
        const Time.seconds(130),
      );
    });
    test("toFullSeconds", () {
      expect(const Time.seconds(5).toFullSeconds, 5);
      expect(const Time.seconds(5.9).toFullSeconds, 5);
    });
    test("truncatedDivision", () {
      expect(
        const Time.seconds(5).truncatedDivision(2),
        equals(const Time.seconds(2)),
      );
      expect(
        const Time.seconds(5.9).truncatedDivision(2),
        equals(const Time.seconds(2)),
      );
      expect(
        const Time.seconds(9).truncatedDivision(2),
        equals(const Time.seconds(4)),
      );
    });
    const cases = <UnitConversion>[
      (from: Time.seconds(5), to: Time.minutes(5 / 60)),
      (from: Time.seconds(7), to: Time(7 / 3600, TimeUnit.hour)),
      (from: Time.minutes(9), to: Time.seconds(9 * 60)),
      (from: Time.minutes(11), to: Time.hours(11 / 60)),
      (from: Time.hours(1), to: Time.seconds(3600)),
      (from: Time.hours(2), to: Time.minutes(120)),
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
      Time.hours(1),
      Time.minutes(59.9),
      Time.seconds(3500),
      Time.seconds(999),
      Time.minutes(12),
      Time.hours(1 / 10),
      Time.seconds(10),
      Time.minutes(1 / 10),
    ];
    for (final currentTime in decreasingTimeList) {
      test("to and from duration", () {
        expect(Time.ofDuration(currentTime.asDuration), currentTime);
      });

      test("test $currentTime >= $currentTime", () {
        expect(currentTime >= currentTime, isTrue);
      });
      test("test $currentTime <= $currentTime", () {
        expect(currentTime <= currentTime, isTrue);
      });
      final largerTimes = decreasingTimeList.takeWhile(
        (value) => value != currentTime,
      );
      for (final largerTime in largerTimes) {
        test("hashcode not equal", () {
          expect(currentTime.hashCode, isNot(equals(largerTime.hashCode)));
        });
        test("compareTo", () {
          expect(largerTime.compareTo(currentTime), equals(1));
          expect(currentTime.compareTo(largerTime), equals(-1));
        });
        test("test $largerTime > $currentTime", () {
          expect(largerTime > currentTime, isTrue);
        });
        test("test $largerTime >= $currentTime", () {
          expect(currentTime >= largerTime, isFalse);
          expect(largerTime >= currentTime, isTrue);
        });
        test("test $currentTime < $largerTime", () {
          expect(largerTime < currentTime, isFalse);
          expect(currentTime < largerTime, isTrue);
        });
        test("test $currentTime <= $largerTime", () {
          expect(largerTime <= currentTime, isFalse);
          expect(currentTime <= largerTime, isTrue);
        });
      }
    }
  });
}
