//TODO: test this class

import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/calc.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class VolumePerTime implements Number {
  final double _value;
  final TimeUnit timeUnit;
  final VolumeUnit volumeUnit;
  const VolumePerTime(this._value, this.timeUnit, this.volumeUnit)
      : assert(_value >= 0);

  String get unitAsString => 'ml/${timeUnit.displayName}';

  @override
  String toString() => toDisplayString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolumePerTime &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, timeUnit: other.timeUnit) ==
              other.asNumber();

  @override
  int get hashCode => Object.hash(_value, timeUnit);

  //TODO: test function
  VolumePerTime _toTimeUnit(TimeUnit toTime) => VolumePerTime(
      _value *
          TimeUnit.convertFactorOnlyTime(fromTime: timeUnit, toTime: toTime),
      toTime,
      volumeUnit);

  VolumePerTime _toVolumeUnit(VolumeUnit toVolume) => VolumePerTime(
      _value * Calc.convertFactorOnlyVolume(from: volumeUnit, to: toVolume),
      timeUnit,
      toVolume);

  VolumePerTime as({VolumeUnit? volumeUnit, TimeUnit? timeUnit}) =>
      _toTimeUnit(timeUnit ?? this.timeUnit)
          ._toVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber({VolumeUnit? volumeUnit, TimeUnit? timeUnit}) =>
      as(volumeUnit: volumeUnit, timeUnit: timeUnit)._value;

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(_value, override, format)} $unitAsString";
  }
}
