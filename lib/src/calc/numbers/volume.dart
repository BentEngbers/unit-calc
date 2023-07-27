import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'number.dart';

@immutable
final class Volume implements Number {
  final VolumeUnit unit;
  final num _value;

  const Volume(this._value, this.unit) : assert(_value >= 0);

  const Volume.ml(this._value)
      : unit = VolumeUnit.ml,
        assert(_value >= 0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Volume &&
          runtimeType == other.runtimeType &&
          asNumber(other.unit) == other.asNumber(other.unit);

  bool operator >(Volume other) =>
      asNumber(other.unit) > other.asNumber(other.unit);

  bool operator <(Volume other) =>
      asNumber(other.unit) < other.asNumber(other.unit);

  bool operator >=(Volume other) =>
      identical(this, other) ||
      asNumber(other.unit) >= other.asNumber(other.unit);

  @override
  int get hashCode => Object.hash(_value, unit);

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${unit.displayName}";

  factory Volume.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String number, [String volume]) => Volume(
            num.parse(number),
            VolumeUnit.fromJson(volume),
          ),
        _ => throw FormatException("invalid json: \"$json\""),
      };

  @override
  String toString() => toDisplayString();

  Volume operator +(Volume volume) =>
      Volume(_value + volume.asNumber(unit), unit);
  Volume operator -(Volume volume) =>
      Volume(_value - volume.asNumber(unit), unit);

  Volume as([VolumeUnit? unit]) => Volume(
        _value * this.unit.convertFactor(to: (unit ?? this.unit)),
        unit ?? this.unit,
      );

  num asNumber([VolumeUnit? unit]) => as(unit)._value;

  @override
  String toJson() => "$_value ${unit.toJson()}";
}
