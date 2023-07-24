import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'Number.dart';

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

  @override
  int get hashCode => Object.hash(_value, unit);

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} $displayUnit";

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
  Volume as(VolumeUnit unit) => Volume(
      _value * Calc.convertFactorOnlyVolume(from: this.unit, to: unit), unit);
  num asNumber(VolumeUnit unit) => as(unit)._value;

  @override
  String get displayUnit => unit.displayName;

  @override
  String toJson() => "$_value $displayUnit";
}
