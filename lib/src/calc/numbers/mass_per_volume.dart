import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'mass.dart';
import 'Volume.dart';

@immutable
class MassPerVolume implements Number {
  final num _value;
  final MassUnit massUnit;
  final VolumeUnit volumeUnit;

  @override
  String get displayUnit => "${massUnit.displayName}/${volumeUnit.displayName}";

  const MassPerVolume(this._value, this.massUnit, this.volumeUnit)
      : assert(_value >= 0);

  //TODO: test this function
  Mass operator *(Volume volume) =>
      Mass(volume.asNumber(volume.unit) * _value, massUnit);

  //TODO: test this function
  MassPerVolume multiply(MassPerVolume massPerVolume) => MassPerVolume(
      _value * massPerVolume.asNumber(volumeUnit: volumeUnit),
      massUnit,
      volumeUnit);

  MassPerVolume _toMassUnit(MassUnit toMass) => MassPerVolume(
      _value * massUnit.convertFactor(to: toMass), toMass, volumeUnit);

  MassPerVolume _toVolumeUnit(VolumeUnit toVolume) => MassPerVolume(
      _value * Calc.convertFactorOnlyVolume(from: volumeUnit, to: toVolume),
      massUnit,
      toVolume);

  MassPerVolume as({VolumeUnit? volumeUnit, MassUnit? massUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber({VolumeUnit? volumeUnit, MassUnit? massUnit}) =>
      as(volumeUnit: volumeUnit, massUnit: massUnit)._value;

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(_value, override, format)} $displayUnit";
  }

  @override
  String toJson() => "$_value $displayUnit";

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

  bool operator >(Object other) =>
      identical(this, other) ||
      other is MassPerVolume &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >
              other.asNumber();

  bool operator >=(Object other) =>
      identical(this, other) ||
      other is MassPerVolume &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >=
              other.asNumber();
  @override
  String toString() => toDisplayString();

  @override
  int get hashCode => Object.hash(_value, massUnit, volumeUnit);
}
