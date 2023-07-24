import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';

import 'enum/time_unit.dart';

const double defaultPrecision = 0.0000000001;

final class Calc {
  static num convertFactor(
          {required MassUnit from,
          required MassUnit to,
          required TimeUnit fromTime,
          required TimeUnit toTime}) =>
      from.convertFactor(to: to) * fromTime.convertFactor(toTime: toTime);

  static num convertFactorOnlyVolume(
      {required VolumeUnit from, required VolumeUnit to}) {
    return from.factorMl / to.factorMl;
  }

  static bool doubleEquals(num a, num b) => (a - b).abs() < defaultPrecision;
}
