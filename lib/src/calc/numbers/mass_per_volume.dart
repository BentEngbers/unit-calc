import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/unit_calc.dart';

@immutable
class MassPerVolume implements Number {
  final num _value;
  final MassUnit massUnit;
  final VolumeUnit volumeUnit;

  @override
  String get displayUnit => "${massUnit.displayName}/${volumeUnit.displayName}";

  const MassPerVolume(this._value, this.massUnit, this.volumeUnit)
      : assert(_value >= 0);

  Mass operator *(Volume volume) =>
      Mass(volume.asNumber(volume.unit) * _value, massUnit);

  MassPerTime multiply(VolumePerTime volumePerTime) => MassPerTime(
      _value * volumePerTime.asNumber(volumeUnit: volumeUnit),
      massUnit,
      volumePerTime.timeUnit);

  MassPerVolume _toMassUnit(MassUnit toMass) => MassPerVolume(
      _value * massUnit.convertFactor(to: toMass), toMass, volumeUnit);

  MassPerVolume _toVolumeUnit(VolumeUnit toVolume) => MassPerVolume(
      _value * volumeUnit.convertFactor(to: toVolume), massUnit, toVolume);

  MassPerVolume as({VolumeUnit? volumeUnit, MassUnit? massUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber({VolumeUnit? volumeUnit, MassUnit? massUnit}) =>
      as(volumeUnit: volumeUnit, massUnit: massUnit)._value;

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(_value, override, format)} $displayUnit";
  }

  @override
  String toJson() => "$_value ${massUnit.toJson()}/${volumeUnit.displayName}";

  @override
  factory MassPerVolume.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String volume]) => MassPerVolume(
            num.parse(value),
            MassUnit.fromJson(mass),
            VolumeUnit.fromJson(volume),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolume &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) ==
              other.asNumber();

  bool operator >(MassPerVolume other) =>
      asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >
      other.asNumber();

  bool operator <(MassPerVolume other) =>
      asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) <
      other.asNumber();

  bool operator >=(MassPerVolume other) =>
      identical(this, other) ||
      asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >=
          other.asNumber();
  @override
  String toString() => toDisplayString();

  @override
  int get hashCode => Object.hash(_value, massUnit, volumeUnit);
}
