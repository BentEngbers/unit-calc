import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/length_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';

/// A length \
/// Example: `170 cm`, `30 m`
@immutable
class Length implements Number {
  final num _value;
  final LengthUnit unit;

  const Length(this._value, this.unit) : assert(_value >= 0);
  const Length.zero([LengthUnit? unit])
    : _value = 0,
      unit = unit ?? LengthUnit.meter;

  const Length.centiMeters(this._value)
    : unit = LengthUnit.centiMeter,
      assert(_value >= 0);

  const Length.meters(this._value)
    : unit = LengthUnit.meter,
      assert(_value >= 0);
  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(_value, override, format)} ${unit.displayName}';

  @override
  String toString() => toDisplayString();

  @override
  String toJson() => "$_value ${unit.toJson()}";

  factory Length.fromJson(String json) => switch (ParseUtilities.splitString(
    json,
  )) {
    (String value, [String lengthUnit]) => Length(
      num.parse(value),
      LengthUnit.fromJson(lengthUnit),
    ),
    _ => throw InvalidJsonException(json),
  };

  Length as([LengthUnit? unit]) => Length(
    _value * this.unit.convertFactor(toLength: unit ?? this.unit),
    unit ?? this.unit,
  );

  num asNumber([LengthUnit? unit]) => as(unit)._value;

  bool operator >(Length other) =>
      asNumber(other.unit) > other.asNumber(other.unit);

  bool operator <(Length other) =>
      asNumber(other.unit) < other.asNumber(other.unit);

  bool operator >=(Length other) =>
      identical(this, other) ||
      asNumber(other.unit) >= other.asNumber(other.unit);

  bool operator <=(Length other) =>
      identical(this, other) ||
      asNumber(other.unit) <= other.asNumber(other.unit);

  @override
  int get hashCode => Object.hash(_value, unit);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Length &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) == other.asNumber(other.unit);
}
