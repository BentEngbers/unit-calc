import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class MassPerVolumeMass implements Number {
  final double _value;
  final MassUnit massUnit;
  final VolumeUnit volumeUnit;

  /// the mass unit that divides the [massUnit]. If you have 5 mg/ml/kg ,then kg is the [perMassUnit].
  final MassUnit perMassUnit;

  const MassPerVolumeMass(
      this._value, this.massUnit, this.volumeUnit, this.perMassUnit)
      : assert(_value >= 0);
  const MassPerVolumeMass.perKg(this._value, this.massUnit, this.volumeUnit)
      : perMassUnit = kiloGram,
        assert(_value >= 0);
  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${volumeUnit.displayName}/${perMassUnit.displayName}";

  @override
  String toString() => toDisplayString();

  MassPerVolume operator *(Mass mass) =>
      MassPerVolume(_value * mass.value, massUnit, volumeUnit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeMass &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) ==
              other.asNumber();

  bool operator >(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeMass &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >
              other.asNumber();

  bool operator >=(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeMass &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.volumeUnit, massUnit: other.massUnit) >=
              other.asNumber();

  MassPerVolumeMass _toMassUnit(MassUnit toMass) => MassPerVolumeMass(
      _value * Calc.convertFactorOnlyUnit(from: massUnit, to: toMass),
      toMass,
      volumeUnit,
      perMassUnit);

  MassPerVolumeMass _toPerMassUnit(MassUnit toMass) => MassPerVolumeMass(
      _value * Calc.convertFactorOnlyUnit(from: perMassUnit, to: toMass),
      toMass,
      volumeUnit,
      perMassUnit);

  MassPerVolumeMass _toVolumeUnit(VolumeUnit toVolume) => MassPerVolumeMass(
      _value * Calc.convertFactorOnlyVolume(from: volumeUnit, to: toVolume),
      massUnit,
      volumeUnit,
      perMassUnit);

  MassPerVolumeMass as(
          {VolumeUnit? volumeUnit,
          MassUnit? massUnit,
          MassUnit? perMassUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toVolumeUnit(volumeUnit ?? this.volumeUnit)
          ._toPerMassUnit(perMassUnit ?? this.perMassUnit);

  num asNumber(
          {VolumeUnit? volumeUnit,
          MassUnit? massUnit,
          MassUnit? perMassUnit}) =>
      as(
        volumeUnit: volumeUnit,
        massUnit: massUnit,
        perMassUnit: perMassUnit,
      )._value;

  @override
  int get hashCode => Object.hash(_value, massUnit, volumeUnit, perMassUnit);
}
