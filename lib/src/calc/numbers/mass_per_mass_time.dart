import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_time.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

@immutable

/// An amount of mass divided by a mass unit per time unit\
/// e.g. 5 mg / (kg * hour)
class MassPerMassTime implements Number {
  final num _value;
  final MassUnit massUnit;
  final MassUnit perMassUnit;
  final TimeUnit perTimeUnit;
  const MassPerMassTime(
      this._value, this.massUnit, this.perMassUnit, this.perTimeUnit)
      : assert(_value > 0);
  const MassPerMassTime.kg(this._value, this.massUnit, this.perTimeUnit)
      : perMassUnit = kiloGram,
        assert(_value > 0);

  String get _unit =>
      "${massUnit.displayName}/${perMassUnit.displayName}/${perTimeUnit.displayName}";

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} $_unit";

  @override
  String toString() => toDisplayString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerMassTime &&
          runtimeType == other.runtimeType &&
          asNumber(
                  massUnit: other.massUnit,
                  perMassUnit: other.perMassUnit,
                  perTimeUnit: other.perTimeUnit) ==
              other.asNumber();

  @override
  int get hashCode => Object.hash(_value, massUnit, perMassUnit);

  //TODO: test this function
  MassPerTime operator *(Mass mass) => MassPerTime(
      mass.asNumber(mass.unit) * asNumber(perMassUnit: mass.unit),
      massUnit,
      perTimeUnit);

  MassPerMassTime _toMassUnit(MassUnit toMass) => MassPerMassTime(
      _value * Calc.convertFactorOnlyUnit(from: massUnit, to: toMass),
      toMass,
      perMassUnit,
      perTimeUnit);

  MassPerMassTime _toPerMassUnit(MassUnit toPerMass) => MassPerMassTime(
      _value * Calc.convertFactorOnlyUnit(from: massUnit, to: toPerMass),
      massUnit,
      toPerMass,
      perTimeUnit);

  MassPerMassTime _toTimeUnit(TimeUnit toPerTime) => MassPerMassTime(
      _value *
          TimeUnit.convertFactorOnlyTime(
            fromTime: perTimeUnit,
            toTime: toPerTime,
          ),
      massUnit,
      perMassUnit,
      toPerTime);

  MassPerMassTime as({
    MassUnit? massUnit,
    MassUnit? perMassUnit,
    TimeUnit? perTimeUnit,
  }) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toPerMassUnit(perMassUnit ?? this.perMassUnit)
          ._toTimeUnit(perTimeUnit ?? this.perTimeUnit);

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
