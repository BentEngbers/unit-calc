import 'package:test/test.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('Length', () {
    test("centiMeter throws an error if initialized with negative number", () {
      expect(() => Length.centiMeters(-1), throwsAssertionError);
    });
    test("meter throws an error if initialized with negative number", () {
      expect(() => Length.meters(-1), throwsAssertionError);
    });
    test("meter throws an error if initialized with negative number", () {
      expect(() => Length(-1, LengthUnit.meter), throwsAssertionError);
    });
    test("check the to string method", () {
      expect(const Length.zero(), const Length(0, LengthUnit.meter));
    });
    test("check the to string method", () {
      expect('${const Length(2.56, LengthUnit.centiMeter)}', "2.56 cm");
    });
    test("equality false", () {
      expect(
        const Length.centiMeters(5) == const Length(5, LengthUnit.meter),
        false,
      );
    });
    test("as", () {
      expect(
        const Length.meters(5).as(LengthUnit.centiMeter).toString(),
        "500 cm",
      );
    });
    test("as", () {
      expect(const Length.meters(5).as().toString(), "5 m");
    });
    test("equality true", () {
      expect(const Length.meters(5) == const Length.centiMeters(500), true);
    });
    test("equality true 2", () {
      expect(const Length.meters(5) == const Length.centiMeters(500), true);
    });
    test("hashFunction", () {
      expect(
        const Length.centiMeters(5000).hashCode,
        isNot(equals(const Length.meters(5).hashCode)),
      );
    });
    test("json round trip", () {
      const length = Length.meters(5000);
      expect(Length.fromJson(length.toJson()), length);
    });
    test("bad json", () {
      expect(
        () => Length.fromJson("3.5 mg/kg/hr"),
        throwsA(
          predicate(
            (x) =>
                x is InvalidJsonException &&
                x.toString() == "InvalidJsonException: \"3.5 mg/kg/hr\"",
          ),
        ),
      );
    });

    const decreasingLengthList = [
      Length(1, LengthUnit.meter),
      Length(99, LengthUnit.centiMeter),
      Length(0.98, LengthUnit.meter),
      Length(1, LengthUnit.centiMeter),
    ];
    for (final currentLength in decreasingLengthList) {
      test("test $currentLength >= $currentLength", () {
        expect(currentLength >= currentLength, isTrue);
      });
      test("test $currentLength <= $currentLength", () {
        expect(currentLength <= currentLength, isTrue);
      });
      final largerMasses = decreasingLengthList.takeWhile(
        (value) => value != currentLength,
      );
      for (final largerMass in largerMasses) {
        test("hashcode not equal", () {
          expect(currentLength.hashCode, isNot(equals(largerMass.hashCode)));
        });
        test("test $largerMass > $currentLength", () {
          expect(largerMass > currentLength, isTrue);
        });
        test("test $largerMass >= $currentLength", () {
          expect(currentLength >= largerMass, isFalse);
          expect(largerMass >= currentLength, isTrue);
        });
        test("test $largerMass <= $currentLength", () {
          expect(largerMass <= currentLength, isFalse);
          expect(currentLength <= largerMass, isTrue);
        });
        test("test $currentLength < $largerMass", () {
          expect(largerMass < currentLength, isFalse);
          expect(currentLength < largerMass, isTrue);
        });
      }
    }
  });
}
