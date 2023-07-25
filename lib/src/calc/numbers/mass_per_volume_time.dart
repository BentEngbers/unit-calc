import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class MassPerVolumeTime implements Number {
  final num _value;
  final MassUnit massUnit;
  final TimeUnit timeUnit;
  final VolumeUnit volumeUnit;
  const MassPerVolumeTime(
    this._value,
    this.massUnit,
    this.volumeUnit,
    this.timeUnit,
  ) : assert(_value > 0);

  @override
  String get displayUnit =>
      "${massUnit.displayName}/${volumeUnit.displayName}/${timeUnit.displayName}";

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} $displayUnit";

  @override
  String toJson() => "$_value $displayUnit";

  factory MassPerVolumeTime.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String number, [String mass, String volume, String time]) =>
          MassPerVolumeTime(
            num.parse(number),
            MassUnit.fromJson(mass),
            VolumeUnit.fromJson(volume),
            TimeUnit.fromJson(time),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeTime &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) ==
              other.asNumber();

  bool operator >(MassPerVolumeTime other) =>
      runtimeType == other.runtimeType &&
      asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >
          other.asNumber();

  bool operator >=(MassPerVolumeTime other) =>
      identical(this, other) ||
      asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >=
          other.asNumber();

  @override
  String toString() => toDisplayString();

  MassPerVolumeTime _toMassUnit(MassUnit toMass) => MassPerVolumeTime(
      _value * massUnit.convertFactor(to: toMass),
      toMass,
      volumeUnit,
      timeUnit);

  MassPerVolumeTime _toVolumeUnit(VolumeUnit toVolume) => MassPerVolumeTime(
      _value * volumeUnit.convertFactor(to: toVolume),
      massUnit,
      volumeUnit,
      timeUnit);

  MassPerVolumeTime as({VolumeUnit? volumeUnit, MassUnit? massUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber({VolumeUnit? volumeUnit, MassUnit? massUnit}) =>
      as(volumeUnit: volumeUnit, massUnit: massUnit)._value;

  @override
  int get hashCode => Object.hash(_value, massUnit, timeUnit, volumeUnit);
}
