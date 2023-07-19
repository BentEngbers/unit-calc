import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

import 'enum/time_unit.dart';

const double defaultPrecision = 0.0000000001;

final class Calc {
  static double convertFactor(
          {required MassUnit from,
          required MassUnit to,
          required TimeUnit fromTime,
          required TimeUnit toTime}) =>
      convertFactorOnlyUnit(from: from, to: to) *
      convertFactorOnlyTime(fromTime: fromTime, toTime: toTime);

  static double convertFactorOnlyUnit(
          {required MassUnit from, required MassUnit to}) =>
      from.factorToMG / to.factorToMG;

  static bool doubleEquals(double a, double b) =>
      (a - b).abs() < defaultPrecision;

  static double convertFactorOnlyTime(
          {required TimeUnit fromTime, required TimeUnit toTime}) =>
      fromTime.factorMin / toTime.factorMin;
}
