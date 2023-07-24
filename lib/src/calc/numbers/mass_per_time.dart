import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/calc.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_mass_time.dart';

import 'package:unit_calc/src/calc/numbers/number.dart';

import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/unit_calc.dart';

@immutable
final class MassPerTime implements Number {
  final num _value;
  final TimeUnit perTimeUnit;
  final MassUnit massUnit;
  const MassPerTime(this._value, this.massUnit, this.perTimeUnit)
      : assert(_value >= 0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerTime &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(
              _value *
                  Calc.convertFactor(
                      from: massUnit,
                      to: other.massUnit,
                      fromTime: perTimeUnit,
                      toTime: other.perTimeUnit),
              other._value);

  @override
  int get hashCode => Object.hash(_value, perTimeUnit, massUnit);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${perTimeUnit.displayName}";
  @override
  String toString() => toDisplayString();

  String toJson() => "$_value $displayUnit";

  factory MassPerTime.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String time]) => MassPerTime(
            num.parse(value),
            MassUnit.fromJson(mass),
            TimeUnit.fromJson(time),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  MassPerTime _toMassUnit(MassUnit toMass) => MassPerTime(
      _value * Calc.convertFactorOnlyUnit(from: massUnit, to: toMass),
      toMass,
      perTimeUnit);
  MassPerTime _toTimeUnit(TimeUnit perTimeUnit) => MassPerTime(
      _value *
          TimeUnit.convertFactorOnlyTime(
              fromTime: perTimeUnit, toTime: perTimeUnit),
      massUnit,
      perTimeUnit);

  MassPerTime as({MassUnit? massUnit, TimeUnit? perTimeUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toTimeUnit(perTimeUnit ?? this.perTimeUnit);

  num asNumber({MassUnit? massUnit, TimeUnit? perTimeUnit}) =>
      as(massUnit: massUnit, perTimeUnit: perTimeUnit)._value;

  VolumePerTime operator /(MassPerVolume volume) => VolumePerTime(
        asNumber(massUnit: volume.massUnit) /
            volume.asNumber(volumeUnit: volume.volumeUnit),
        perTimeUnit,
        volume.volumeUnit,
      );

  //TODO: test this function div
  MassPerMassTime divide(Mass patientWeight) => MassPerMassTime(
        asNumber() / patientWeight.asNumber(),
        massUnit,
        patientWeight.unit,
        perTimeUnit,
      );

  @override
  String get displayUnit =>
      "${massUnit.displayName}/${perTimeUnit.displayName}";
}
