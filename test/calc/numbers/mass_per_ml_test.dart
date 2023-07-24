import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';

void main() {
  group('AmountPerML', () {
    test("throws an error if initialized with negative number", () {
      expect(() => MassPerVolume(-1, microGram, VolumeUnit.ml),
          throwsA(isA<AssertionError>()));
    });
    test("check the to string method", () {
      expect('${MassPerVolume(2.56, U(factorToNg: 1), VolumeUnit.ml)}',
          "2.56 U/ml");
    });
  });
}
