import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

@immutable

/// An amount of mass divided by another mass unit\
/// e.g. 5 mg / kg
class MassPerMass implements Number {
  final num _value;

  /// the mass unit. If you have 5 mg/kg ,then mg is the mass unit.
  final MassUnit massUnit;

  /// the mass unit that divides. If you have 5mg/kg ,then kg is the dividing mass unit.
  final MassUnit perMassUnit;

  const MassPerMass(
    this._value,
    this.massUnit,
    this.perMassUnit,
  ) : assert(_value >= 0);

  const MassPerMass.perKg(
    this._value,
    this.massUnit,
  )   : perMassUnit = kiloGram,
        assert(_value >= 0);
  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${perMassUnit.displayName}";
  @override
  String toString() => toDisplayString();

  @override
  String toJson() => "$_value ${massUnit.toJson()}/${perMassUnit.toJson()}";

  factory MassPerMass.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String perMass]) => MassPerMass(
            num.parse(value),
            MassUnit.fromJson(mass),
            MassUnit.fromJson(perMass),
          ),
        _ => throw InvalidJsonException(json),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerMass &&
          runtimeType == other.runtimeType &&
          asNumber(massUnit: other.massUnit, perMassUnit: other.perMassUnit) ==
              other.asNumber();

  @override
  int get hashCode => Object.hash(_value, massUnit, perMassUnit);

  MassPerMass _toMassUnit(MassUnit toMass) => MassPerMass(
        _value * massUnit.convertFactor(to: toMass),
        toMass,
        perMassUnit,
      );

  MassPerMass _toPerMassUnit(MassUnit toPerMass) => MassPerMass(
        _value / perMassUnit.convertFactor(to: toPerMass),
        massUnit,
        toPerMass,
      );

  MassPerMass as({MassUnit? massUnit, MassUnit? perMassUnit}) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toPerMassUnit(perMassUnit ?? this.perMassUnit);

  num asNumber({MassUnit? massUnit, MassUnit? perMassUnit}) =>
      as(massUnit: massUnit, perMassUnit: perMassUnit)._value;

  Mass multiplyWithMass(Mass mass) {
    // (mg / kg) * kg = mg
    return Mass.milliGram(
      asNumber(massUnit: milliGram, perMassUnit: kiloGram) *
          mass.asNumber(kiloGram),
    );
  }
}
