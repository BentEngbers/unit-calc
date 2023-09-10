import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

/// A mass divided by a volume
/// Example: `5 mg/ml`
@immutable
class MassPerVolume implements Number {
  final num _value;
  final MassUnit massUnit;
  final VolumeUnit volumeUnit;

  const MassPerVolume(this._value, this.massUnit, this.volumeUnit)
      : assert(_value >= 0);

  const MassPerVolume.zero([MassUnit? massUnit, VolumeUnit? volumeUnit])
      : _value = 0,
        massUnit = massUnit ?? MassUnit.kiloGram,
        volumeUnit = volumeUnit ?? VolumeUnit.milliLiters;

  Mass operator *(Volume volume) =>
      Mass(volume.asNumber(volumeUnit) * _value, massUnit);

  MassPerTime multiply(VolumePerTime volumePerTime) => MassPerTime(
        _value * volumePerTime.asNumber(volumeUnit),
        massUnit,
        volumePerTime.timeUnit,
      );

  MassPerVolume _toMassUnit(MassUnit toMass) => MassPerVolume(
        _value * massUnit.convertFactor(to: toMass),
        toMass,
        volumeUnit,
      );

  MassPerVolume _toPerVolumeUnit(VolumeUnit toVolume) => MassPerVolume(
        _value / volumeUnit.convertFactor(to: toVolume),
        massUnit,
        toVolume,
      );

  MassPerVolume as(
    MassUnit? massUnit,
    VolumeUnit? volumeUnit,
  ) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toPerVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber([
    MassUnit? massUnit,
    VolumeUnit? volumeUnit,
  ]) =>
      as(massUnit, volumeUnit)._value;

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${volumeUnit.displayName}";
  }

  @override
  String toJson() => "$_value ${massUnit.toJson()}/${volumeUnit.toJson()}";

  @override
  factory MassPerVolume.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String volume]) => MassPerVolume(
            num.parse(value),
            MassUnit.fromJson(mass),
            VolumeUnit.fromJson(volume),
          ),
        _ => throw InvalidJsonException(json),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolume &&
          runtimeType == other.runtimeType &&
          asNumber(other.massUnit, other.volumeUnit) == other.asNumber();

  bool operator >(MassPerVolume other) =>
      asNumber(other.massUnit, other.volumeUnit) > other.asNumber();

  bool operator <(MassPerVolume other) =>
      asNumber(other.massUnit, other.volumeUnit) < other.asNumber();

  bool operator >=(MassPerVolume other) =>
      identical(this, other) ||
      asNumber(other.massUnit, other.volumeUnit) >= other.asNumber();

  bool operator <=(MassPerVolume other) =>
      identical(this, other) ||
      asNumber(other.massUnit, other.volumeUnit) <= other.asNumber();

  @override
  String toString() => toDisplayString();

  @override
  int get hashCode => Object.hash(_value, massUnit, volumeUnit);
}
