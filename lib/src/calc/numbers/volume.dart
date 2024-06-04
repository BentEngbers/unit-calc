import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

/// A volume
/// Example: `5 ml`
@immutable
final class Volume implements Number {
  final VolumeUnit unit;
  final num _value;

  const Volume(this._value, this.unit) : assert(_value >= 0);

  const Volume.milliLiters(this._value)
      : unit = VolumeUnit.milliLiters,
        assert(_value >= 0);

  const Volume.liters(this._value)
      : unit = VolumeUnit.liter,
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
        _ => throw InvalidJsonException(json),
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

  Mass operator *(MassPerVolume dilution) => dilution * this;
}
