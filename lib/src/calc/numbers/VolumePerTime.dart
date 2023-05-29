//TODO: test this class

import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/TimeUnit.dart';
import 'package:unit_calc/src/calc/numbers/Volume.dart';

@immutable
class VolumePerTime extends AbstractVolume {
  final TimeUnit _timeUnit;
  TimeUnit get timeUnit => _timeUnit;
  VolumePerTime(double value, this._timeUnit) : super(value);
  String _todisplayString(String number) => '$number/${_timeUnit.name}';

  @override
  String toFixedDecimalString({int minDigit = 1, int maxDigit = 1}) =>
      _todisplayString(
          super.toFixedDecimalString(minDigit: minDigit, maxDigit: maxDigit));

  @override
  String toString() => super.toDynamicDecimalString;

  //TODO: test function
  VolumePerTime toTimeUnit(TimeUnit toTime) => VolumePerTime(
      value * Calc.convertFactorOnlyTime(fromTime: timeUnit, toTime: toTime),
      toTime);
}
