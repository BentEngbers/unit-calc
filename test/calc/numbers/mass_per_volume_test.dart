import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/unit_calc.dart';

// ignore: camel_case_types
typedef _testCaseMultiplyVolume = ({
  MassPerVolume val,
  Volume multiply,
  Mass result
});

final throwAssertionError = throwsA(isA<AssertionError>());
void main() {
  const List<_testCaseMultiplyVolume> testCases = [
    (
      val: MassPerVolume(2.56, U(factorToNg: 1), VolumeUnit.ml),
      multiply: Volume(5, VolumeUnit.ml),
      result: Mass(12.8, U(factorToNg: 1))
    ),
    (
      val: MassPerVolume(2.56, kiloGram, VolumeUnit.ml),
      multiply: Volume(5, VolumeUnit.ml),
      result: Mass(12.8, kiloGram)
    )
  ];
  test("Check extra units fail", () {
    expect(() => MassPerVolume.fromJson("5 mg/ml/hr"), throwsFormatException);
  });
  group('MassPerVolume', () {
    for (final (:val, :multiply, :result) in testCases) {
      final elementsBefore = testCases.takeWhile((value) => value.val != val);

      test("hashcode", () {
        expect(
            val.hashCode,
            isNot(isIn(testCases
                .where((element) => element.val != val)
                .map((e) => e.val.hashCode))));
      });
      test("larger or equal to itself than previous elements", () {
        expect(val >= val, isTrue);
      });
      for (final before in elementsBefore) {
        test("previous elements smaller then current element", () {
          expect(before.val < val, isTrue);
        });
        test("larger than previous elements", () {
          expect(val > before.val, isTrue);
        });
        test("larger than previous elements", () {
          expect(val >= before.val, isTrue);
        });
      }
      test("json RoundTrip", () {
        expect(MassPerVolume.fromJson(val.toJson()), equals(val));
      });
      test("multiply $val with $multiply", () {
        expect(val * multiply, equals(result));
      });
    }
    test("", () {
      expect(
          MassPerVolume(5, milliGram, VolumeUnit.ml)
              .multiply(VolumePerTime(3, VolumeUnit.ml, TimeUnit.hr)),
          MassPerTime(15, milliGram, TimeUnit.hr));
    });
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerVolume(-1, microGram, VolumeUnit.ml),
          throwAssertionError);
    });
    test("check the to string method", () {
      expect('${MassPerVolume(2.56, U(factorToNg: 1), VolumeUnit.ml)}',
          "2.56 U/ml");
    });
  });
}
