import 'package:unit_calc/src/calc/enum/length_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

class Length implements Number {
  final num _value;
  final LengthUnit unit;

  const Length(this._value, this.unit) : assert(_value >= 0);
  const Length.zero()
      : _value = 0,
        unit = LengthUnit.meter;
  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      '${NumberUtils.toDecimalString(_value, override, format)} ${unit.displayName}';

  @override
  String toString() => toDisplayString();

  @override
  String toJson() => "$_value ${unit.toJson()}";

  factory Length.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String length]) => Length(
            num.parse(value),
            LengthUnit.fromJson(length),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };
  Length.cm(this._value)
      : unit = LengthUnit.centiMeter,
        assert(_value >= 0);
  Length as([LengthUnit? unit]) => Length(
        _value * this.unit.convertFactor(toLength: unit ?? this.unit),
        this.unit,
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
}
