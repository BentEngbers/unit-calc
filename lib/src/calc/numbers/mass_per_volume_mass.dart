import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable
class MassPerVolumeMass implements Number {
  final num _value;
  final MassUnit massUnit;
  final VolumeUnit perVolumeUnit;

  /// the mass unit that divides the [massUnit]. If you have 5 mg/ml/kg ,then kg is the [perMassUnit].
  final MassUnit perMassUnit;

  const MassPerVolumeMass(
      this._value, this.massUnit, this.perVolumeUnit, this.perMassUnit)
      : assert(_value >= 0);
  const MassPerVolumeMass.perKg(this._value, this.massUnit, this.perVolumeUnit)
      : perMassUnit = kiloGram,
        assert(_value >= 0);
  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${perVolumeUnit.displayName}/${perMassUnit.displayName}";

  @override
  String toString() => toDisplayString();

  @override
  String toJson() => "$_value $displayUnit";

  factory MassPerVolumeMass.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String perVolume, String perMass]) =>
          MassPerVolumeMass(
            num.parse(value),
            MassUnit.fromJson(mass),
            VolumeUnit.fromJson(perVolume),
            MassUnit.fromJson(perMass),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  MassPerVolume operator *(Mass mass) => MassPerVolume(
      asNumber(massUnit: mass.unit) * mass.asNumber(), massUnit, perVolumeUnit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeMass &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.perVolumeUnit, massUnit: other.massUnit) ==
              other.asNumber();

  bool operator >(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeMass &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.perVolumeUnit, massUnit: other.massUnit) >
              other.asNumber();

  bool operator >=(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeMass &&
          runtimeType == other.runtimeType &&
          asNumber(volumeUnit: other.perVolumeUnit, massUnit: other.massUnit) >=
              other.asNumber();

  MassPerVolumeMass _toMassUnit(MassUnit toMass) => MassPerVolumeMass(
      _value * massUnit.convertFactor(to: toMass),
      toMass,
      perVolumeUnit,
      perMassUnit);

  MassPerVolumeMass _toPerMassUnit(MassUnit toMass) => MassPerVolumeMass(
      _value * perMassUnit.convertFactor(to: toMass),
      toMass,
      perVolumeUnit,
      perMassUnit);

  MassPerVolumeMass _toVolumeUnit(VolumeUnit toVolume) => MassPerVolumeMass(
      _value * perVolumeUnit.convertFactor(to: toVolume),
      massUnit,
      perVolumeUnit,
      perMassUnit);

  MassPerVolumeMass as(
          {VolumeUnit? volumeUnit,
          MassUnit? massUnit,
          MassUnit? perMassUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toVolumeUnit(volumeUnit ?? perVolumeUnit)
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
  int get hashCode => Object.hash(_value, massUnit, perVolumeUnit, perMassUnit);

  @override
  String get displayUnit =>
      "${massUnit.displayName}/${perVolumeUnit.displayName}/${perMassUnit.displayName}";
}
