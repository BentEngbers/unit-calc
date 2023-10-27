import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_volume.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

import 'number.dart';
import 'volume.dart';

/// A mass \
/// Example: `5 mg`
@immutable
class Mass implements Number {
  final num _value;
  final MassUnit unit;

  const Mass(this._value, this.unit) : assert(_value >= 0);

  const Mass.kiloGrams(this._value)
      : unit = MassUnit.kiloGram,
        assert(_value >= 0);

  const Mass.milliGrams(this._value)
      : unit = MassUnit.milliGram,
        assert(_value >= 0);

  const Mass.zero([MassUnit? unit])
      : _value = 0,
        unit = unit ?? MassUnit.kiloGram;

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(_value, override, format)} ${unit.displayName}';

  @override
  String toString() => toDisplayString();

  MassPerVolume divide(Volume volume) =>
      MassPerVolume(_value / volume.asNumber(volume.unit), unit, volume.unit);

  Mass as([MassUnit? toUnit]) =>
      Mass(_value * unit.convertFactor(to: toUnit ?? unit), toUnit ?? unit);

  num asNumber([MassUnit? toUnit]) => as(toUnit)._value;

  Volume operator /(MassPerVolume concentration) => Volume(
        asNumber(concentration.massUnit) / concentration.asNumber(),
        concentration.volumeUnit,
      );
  MassPerMass divideMass(Mass mass) =>
      // ignore: unnecessary_this
      MassPerMass(
        // ignore: unnecessary_this
        this.asNumber(this.unit) / mass.asNumber(mass.unit),
        // ignore: unnecessary_this
        this.unit,
        mass.unit,
      );
  Mass operator +(Mass other) =>
      Mass(asNumber(other.unit) + other._value, other.unit);
  Mass operator -(Mass other) =>
      Mass(asNumber(other.unit) - other._value, other.unit);
  @override
  String toJson() => "$_value ${unit.toJson()}";

  factory Mass.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass]) => Mass(
            num.parse(value),
            MassUnit.fromJson(mass),
          ),
        _ => throw InvalidJsonException(json),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mass &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) == other.asNumber(other.unit);

  bool operator >(Mass other) =>
      asNumber(other.unit) > other.asNumber(other.unit);

  bool operator <(Mass other) =>
      asNumber(other.unit) < other.asNumber(other.unit);

  bool operator >=(Mass other) =>
      identical(this, other) ||
      asNumber(other.unit) >= other.asNumber(other.unit);
  bool operator <=(Mass other) =>
      identical(this, other) ||
      asNumber(other.unit) <= other.asNumber(other.unit);

  @override
  int get hashCode => Object.hash(_value, unit);
}
