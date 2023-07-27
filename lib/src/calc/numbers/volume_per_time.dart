
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class VolumePerTime implements Number {
  final num _value;
  final TimeUnit timeUnit;
  final VolumeUnit volumeUnit;
  const VolumePerTime(
    this._value,
    this.volumeUnit,
    this.timeUnit,
  ) : assert(_value >= 0);

  @override
  String get displayUnit => '${volumeUnit.displayName}/${timeUnit.displayName}';

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

  @override
  String toJson() => "$_value ${volumeUnit.displayName}/${timeUnit.toJson()}";

  factory VolumePerTime.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String volume, String timeUnit]) => VolumePerTime(
            num.parse(value),
            VolumeUnit.fromJson(volume),
            TimeUnit.fromJson(timeUnit),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };
  VolumePerTime _toTimeUnit(TimeUnit toTime) => VolumePerTime(
      _value * timeUnit.convertFactor(toTime: toTime), volumeUnit, toTime);

  VolumePerTime _toVolumeUnit(VolumeUnit toVolume) => VolumePerTime(
        _value * volumeUnit.convertFactor(to: toVolume),
        toVolume,
        timeUnit,
      );

  VolumePerTime as({VolumeUnit? volumeUnit, TimeUnit? timeUnit}) =>
      _toTimeUnit(timeUnit ?? this.timeUnit)
          ._toVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber({VolumeUnit? volumeUnit, TimeUnit? timeUnit}) =>
      as(volumeUnit: volumeUnit, timeUnit: timeUnit)._value;

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(_value, override, format)} $displayUnit";
  }
}
