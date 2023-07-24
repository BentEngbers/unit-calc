import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';
import 'Volume.dart';

@immutable
class Mass implements Number {
  final num _value;
  final MassUnit unit;

  const Mass(this._value, this.unit) : assert(_value >= 0);
  const Mass.kiloGram(this._value)
      : unit = kiloGram,
        assert(_value >= 0);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(_value, override, format)} ${unit.displayName}';

  @override
  String toString() => toDisplayString();

  MassPerVolume divide(Volume volume) =>
      MassPerVolume(_value / volume.asNumber(volume.unit), unit, volume.unit);

  Mass as([MassUnit? toUnit]) => Mass(
      _value * Calc.convertFactorOnlyUnit(from: unit, to: toUnit ?? unit),
      toUnit ?? unit);

  num asNumber([MassUnit? toUnit]) => as(toUnit)._value;

  Volume operator /(MassPerVolume concentration) => Volume(
      asNumber(concentration.massUnit) / concentration.asNumber(),
      concentration.volumeUnit);

  @override
  String toJson() => "$_value ${unit.displayName}";

  factory Mass.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass]) => Mass(
            num.parse(value),
            MassUnit.fromJson(mass),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) == other.asNumber(other.unit);

  bool operator >(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) > other.asNumber(other.unit);

  bool operator >=(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) >= other.asNumber(other.unit);

  @override
  int get hashCode => Object.hash(_value, unit);

  @override
  // TODO: implement displayUnit
  String get displayUnit => unit.displayName;
}
