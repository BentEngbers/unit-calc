import 'package:test/test.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';

void main() {
  group("MassPerVolume", () {
    test('round trip json serializable', () {
      final massPerVolume = MassPerVolume(5.4, kiloGram, VolumeUnit.ml);
      expect(MassPerVolume.fromJson(massPerVolume.toJson()), massPerVolume);
    });
  });
}
