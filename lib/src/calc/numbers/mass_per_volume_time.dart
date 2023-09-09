import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/mass_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/enum/volume_unit.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';

/// A mass divided by a volume and by time\
/// Example: `5 mg/ml/min`
@immutable
class MassPerVolumeTime implements Number {
  final num _value;
  final MassUnit massUnit;
  final TimeUnit timeUnit;
  final VolumeUnit volumeUnit;
  const MassPerVolumeTime(
    this._value,
    this.massUnit,
    this.volumeUnit,
    this.timeUnit,
  ) : assert(_value >= 0);

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${volumeUnit.displayName}/${timeUnit.displayName}";

  @override
  String toJson() =>
      "$_value ${massUnit.toJson()}/${volumeUnit.toJson()}/${timeUnit.toJson()}";

  factory MassPerVolumeTime.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String number, [String mass, String volume, String time]) =>
          MassPerVolumeTime(
            num.parse(number),
            MassUnit.fromJson(mass),
            VolumeUnit.fromJson(volume),
            TimeUnit.fromJson(time),
          ),
        _ => throw InvalidJsonException(json),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerVolumeTime &&
          runtimeType == other.runtimeType &&
          asNumber(other.volumeUnit, other.massUnit) == other.asNumber();

  bool operator >(MassPerVolumeTime other) =>
      runtimeType == other.runtimeType &&
      asNumber(other.volumeUnit, other.massUnit) > other.asNumber();

  bool operator >=(MassPerVolumeTime other) =>
      identical(this, other) ||
      asNumber(other.volumeUnit, other.massUnit) >= other.asNumber();

  @override
  String toString() => toDisplayString();

  MassPerVolumeTime _toMassUnit(MassUnit toMass) => MassPerVolumeTime(
        _value * massUnit.convertFactor(to: toMass),
        toMass,
        volumeUnit,
        timeUnit,
      );

  MassPerVolumeTime _toPerVolumeUnit(VolumeUnit toVolume) => MassPerVolumeTime(
        _value / volumeUnit.convertFactor(to: toVolume),
        massUnit,
        volumeUnit,
        timeUnit,
      );

  MassPerVolumeTime as(VolumeUnit? volumeUnit, MassUnit? massUnit) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toPerVolumeUnit(volumeUnit ?? this.volumeUnit);

  num asNumber([VolumeUnit? volumeUnit, MassUnit? massUnit]) =>
      as(volumeUnit, massUnit)._value;

  @override
  int get hashCode => Object.hash(_value, massUnit, timeUnit, volumeUnit);
}
