import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_time.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable

/// An amount of mass divided by a mass unit per time unit\
/// Example: 5 mg/kg/hour
class MassPerMassTime implements Number {
  final num _value;
  final MassUnit massUnit;
  final MassUnit perMassUnit;
  final TimeUnit perTimeUnit;
  const MassPerMassTime(
    this._value,
    this.massUnit,
    this.perMassUnit,
    this.perTimeUnit,
  ) : assert(_value >= 0);
  const MassPerMassTime.perKg(this._value, this.massUnit, this.perTimeUnit)
      : perMassUnit = kiloGram,
        assert(_value >= 0);

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${perMassUnit.displayName}/${perTimeUnit.displayName}";

  @override
  String toString() => toDisplayString();

  @override
  String toJson() =>
      "$_value ${massUnit.toJson()}/${perMassUnit.toJson()}/${perTimeUnit.toJson()}";

  factory MassPerMassTime.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String perMass, String perTime]) =>
          MassPerMassTime(
            num.parse(value),
            MassUnit.fromJson(mass),
            MassUnit.fromJson(perMass),
            TimeUnit.fromJson(perTime),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerMassTime &&
          runtimeType == other.runtimeType &&
          asNumber(
                massUnit: other.massUnit,
                perMassUnit: other.perMassUnit,
                perTimeUnit: other.perTimeUnit,
              ) ==
              other.asNumber();

  @override
  int get hashCode => Object.hash(_value, massUnit, perMassUnit, perTimeUnit);

  MassPerTime operator *(Mass mass) => MassPerTime(
        asNumber() * mass.asNumber(perMassUnit),
        massUnit,
        perTimeUnit,
      );

  MassPerMassTime _toMassUnit(MassUnit toMass) => MassPerMassTime(
        _value * massUnit.convertFactor(to: toMass),
        toMass,
        perMassUnit,
        perTimeUnit,
      );

  MassPerMassTime _toPerMassUnit(MassUnit toPerMass) => MassPerMassTime(
        _value / perMassUnit.convertFactor(to: toPerMass),
        massUnit,
        toPerMass,
        perTimeUnit,
      );

  MassPerMassTime _toPerTimeUnit(TimeUnit toPerTime) => MassPerMassTime(
        _value /
            perTimeUnit.convertFactor(
              toTime: toPerTime,
            ),
        massUnit,
        perMassUnit,
        toPerTime,
      );

  MassPerMassTime as({
    MassUnit? massUnit,
    MassUnit? perMassUnit,
    TimeUnit? perTimeUnit,
  }) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toPerMassUnit(perMassUnit ?? this.perMassUnit)
          ._toPerTimeUnit(perTimeUnit ?? this.perTimeUnit);

  num asNumber({
    MassUnit? massUnit,
    MassUnit? perMassUnit,
    TimeUnit? perTimeUnit,
  }) =>
      as(
        massUnit: massUnit,
        perMassUnit: perMassUnit,
        perTimeUnit: perTimeUnit,
      )._value;
}
