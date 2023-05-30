import 'package:unit_calc/src/calc/enum/concentration_unit.dart';

import 'enum/time_unit.dart';

const double defaultPrecision = 0.0000000001;

class Calc {
  static double convertFactor(
          {required ConcentrationUnit from,
          required ConcentrationUnit to,
          required TimeUnit fromTime,
          required TimeUnit toTime}) =>
      convertFactorOnlyUnit(from: from, to: to) *
      convertFactorOnlyTime(fromTime: fromTime, toTime: toTime);

  static double convertFactorOnlyUnit(
      {required ConcentrationUnit from, required ConcentrationUnit to}) {
    return from.factorToMG / to.factorToMG;
  }

  static bool doubleEquals(double a, double b) {
    double epsilon = defaultPrecision;
    return (a - b).abs() < epsilon;
  }

  static double convertFactorOnlyTime(
      {required TimeUnit fromTime, required TimeUnit toTime}) {
    return fromTime.factorMin / toTime.factorMin;
  }
}
