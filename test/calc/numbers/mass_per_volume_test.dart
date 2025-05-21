import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

// ignore: camel_case_types
typedef _testCaseMultiplyVolume =
    ({MassPerVolume val, Volume multiply, Mass result});

final throwsAssertionError = throwsA(isA<AssertionError>());
final throwsInvalidJsonException = throwsA(isA<InvalidJsonException>());

void main() {
  const List<_testCaseMultiplyVolume> testCases = [
    (
      val: MassPerVolume(2.56, U(factorToNg: 1), VolumeUnit.milliLiters),
      multiply: Volume(5, VolumeUnit.milliLiters),
      result: Mass(12.8, U(factorToNg: 1)),
    ),
    (
      val: MassPerVolume(2.56, MassUnit.kiloGram, VolumeUnit.milliLiters),
      multiply: Volume(5, VolumeUnit.milliLiters),
      result: Mass(12.8, MassUnit.kiloGram),
    ),
  ];
  group('MassPerVolume', () {
    test("Zero constructor", () {
      expect(
        const MassPerVolume.zero(),
        const MassPerVolume(0, MassUnit.milliGram, VolumeUnit.liter),
      );
    });
    test("Check extra units fail", () {
      expect(
        () => MassPerVolume.fromJson("5 mg/ml/hr"),
        throwsInvalidJsonException,
      );
    });
    for (final (:val, :multiply, :result) in testCases) {
      final elementsBefore = testCases.takeWhile((value) => value.val != val);

      test("hashcode", () {
        expect(
          val.hashCode,
          isNot(
            isIn(
              testCases
                  .where((element) => element.val != val)
                  .map((e) => e.val.hashCode),
            ),
          ),
        );
      });
      test("larger or equal to itself", () {
        expect(val >= val, isTrue);
      });
      test("smaller or equal to itself", () {
        expect(val <= val, isTrue);
      });
      for (final before in elementsBefore) {
        test("previous elements smaller then current element", () {
          expect(before.val < val, isTrue);
        });
        test("larger than previous elements", () {
          expect(val > before.val, isTrue);
        });
        test("larger or equal than previous elements", () {
          expect(val >= before.val, isTrue);
        });
        test("larger than previous elements", () {
          expect(before.val <= val, isTrue);
        });
      }
      test("json RoundTrip", () {
        expect(MassPerVolume.fromJson(val.toJson()), equals(val));
      });
      test("multiply $val with $multiply", () {
        expect(val * multiply, equals(result));
      });
      test("multiply $multiply with $val", () {
        expect(multiply * val, equals(result));
      });
    }
    test("multiply by volumePerTime", () {
      expect(
        const MassPerVolume(
          5,
          MassUnit.milliGram,
          VolumeUnit.milliLiters,
        ).multiply(
          const VolumePerTime(3, VolumeUnit.milliLiters, TimeUnit.hour),
        ),
        const MassPerTime(15, MassUnit.milliGram, TimeUnit.hour),
      );
    });
    test("multiply with volume from readme", () {
      expect(
        const MassPerVolume(50, MassUnit.milliGram, VolumeUnit.liter) *
            const Volume(100, VolumeUnit.milliLiters),
        equals(const Mass.milliGrams(5)),
      );
    });

    test("throws an error if initialized with negative number", () {
      expect(
        () => MassPerVolume(-1, MassUnit.microGram, VolumeUnit.milliLiters),
        throwsAssertionError,
      );
    });
    test("check the to string method", () {
      expect(
        '${const MassPerVolume(2.56, U(factorToNg: 1), VolumeUnit.milliLiters)}',
        "2.56 U/ml",
      );
    });
  });
}
