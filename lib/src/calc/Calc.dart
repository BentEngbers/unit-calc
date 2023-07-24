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
      convertFactorOnlyUnit(from: from, to: to) *
      TimeUnit.convertFactorOnlyTime(fromTime: fromTime, toTime: toTime);

  static num convertFactorOnlyUnit(
          {required MassUnit from, required MassUnit to}) =>
      from.factorNanoGr / to.factorNanoGr;
  static num convertFactorOnlyVolume(
      {required VolumeUnit from, required VolumeUnit to}) {
    return from.factorMl / to.factorMl;
  }

  static bool doubleEquals(num a, num b) => (a - b).abs() < defaultPrecision;
}
