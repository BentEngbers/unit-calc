import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/syringe_sizes.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/volume.dart';

import 'mass_per_volume_test.dart';

void main() {
  group('Volume:', () {
    test("throws an error if initialized with negative number", () {
      expect(() => Volume.milliliter(-1), throwAssertionError);
    });
    test("throws error when result is negative", () {
      expect(
        () => {const Volume.milliliter(1) - SyringeSizes.ml20.volume},
        throwAssertionError,
      );
    });
    test("check addition", () {
      final a = const Volume.milliliter(1) + SyringeSizes.ml10.volume;
      expect(a, const Volume.milliliter(11));
    });
    test("check equality", () {
      expect(const Mass.kiloGram(5), isNot(const Volume.milliliter(5)));
    });
    test("check the tostring method", () {
      expect(const Volume.milliliter(10).toString(), "10 ml");
    });
    test("check the tostring method", () {
      expect(const Volume.milliliter(10.14).toString(), "10.1 ml");
    });
    test("check the toFixedDecimalString method", () {
      expect(
        const Volume.milliliter(10).toDisplayString((minDigit: 2, maxDigit: 2)),
        "10.00 ml",
      );
    });
    test("check the toFixedDecimalString method", () {
      expect(
        const Volume.milliliter(5.5)
            .toDisplayString((minDigit: 0, maxDigit: 0)),
        "6 ml",
      );
    });
    test("test equals", () {
      expect(const Volume.milliliter(1), const Volume.milliliter(1));
    });
    test("json ", () {
      expect(() => Volume.fromJson("2 ml/mg"), throwsFormatException);
    });
    const decreasingVolumeList = [
      Volume(2, VolumeUnit.ml),
      Volume(0.2, VolumeUnit.ml),
      Volume(0.1, VolumeUnit.ml)
    ];
    for (final currentVolume in decreasingVolumeList) {
      test("test $currentVolume >= $currentVolume", () {
        expect(currentVolume >= currentVolume, isTrue);
      });
      test("json roundtrip", () {
        expect(Volume.fromJson(currentVolume.toJson()), currentVolume);
      });
      test("check as", () {
        expect(currentVolume.as(), currentVolume);
      });
      final elementsBefore =
          decreasingVolumeList.takeWhile((value) => value != currentVolume);
      for (final volumeBefore in elementsBefore) {
        test("hashcode not equal", () {
          expect(currentVolume.hashCode, isNot(equals(volumeBefore.hashCode)));
        });
        test("test $volumeBefore > $currentVolume", () {
          expect(volumeBefore > currentVolume, isTrue);
        });
        test("test $volumeBefore >= $currentVolume", () {
          expect(currentVolume >= volumeBefore, isFalse);
          expect(volumeBefore >= currentVolume, isTrue);
        });
        test("test $currentVolume < $volumeBefore", () {
          expect(volumeBefore < currentVolume, isFalse);
          expect(currentVolume < volumeBefore, isTrue);
        });
      }
    }
  });
}
