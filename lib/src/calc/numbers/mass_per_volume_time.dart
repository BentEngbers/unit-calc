import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
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
  String toDisplayString([DigitOverride? override, NumberFormat? format]) {
    return "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${volumeUnit.displayName}/${timeUnit.displayName}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeTime &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) ==
              other.asNumber();

  bool operator >(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeTime &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >
              other.asNumber();

  bool operator >=(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeTime &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >=
              other.asNumber();

  @override
  String toString() => toDisplayString();

  MassPerVolumeTime _toMassUnit(MassUnit toMass) => MassPerVolumeTime(
      _value * Calc.convertFactorOnlyUnit(from: massUnit, to: toMass),
      toMass,
      volumeUnit,
      timeUnit);

  MassPerVolumeTime _toVolumeUnit(VolumeUnit toVolume) => MassPerVolumeTime(
      _value * Calc.convertFactorOnlyVolume(from: volumeUnit, to: toVolume),
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
