import 'package:meta/meta.dart';


import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/src/exceptions.dart';
import 'package:unit_calc/unit_calc.dart';

/// An amount of mass divided by a time unit\
/// Example: `5 mg/min`
@immutable
final class MassPerTime implements Number {
  final num _value;
  final TimeUnit perTimeUnit;
  final MassUnit massUnit;
  const MassPerTime(this._value, this.massUnit, this.perTimeUnit)
      : assert(_value >= 0);

  const MassPerTime.zero([MassUnit? massUnit, TimeUnit? perTimeUnit])
      : _value = 0,
        massUnit = massUnit ?? MassUnit.kiloGram,
        perTimeUnit = perTimeUnit ?? TimeUnit.second;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerTime &&
          runtimeType == other.runtimeType &&
          (_value *
                  massUnit.convertFactor(to: other.massUnit) *
                  perTimeUnit.convertFactor(toTime: other.perTimeUnit)) ==
              other._value;

  @override
  int get hashCode => Object.hash(_value, perTimeUnit, massUnit);

  @override
  String toDisplayString([DigitPrecision? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(_value, override, format)} ${massUnit.displayName}/${perTimeUnit.displayName}";
  @override
  String toString() => toDisplayString();

  @override
  String toJson() => "$_value ${massUnit.toJson()}/${perTimeUnit.toJson()}";

  factory MassPerTime.fromJson(String json) =>
      switch (ParseUtilities.splitString(json)) {
        (String value, [String mass, String time]) => MassPerTime(
            num.parse(value),
            MassUnit.fromJson(mass),
            TimeUnit.fromJson(time),
          ),
        _ => throw InvalidJsonException(json),
      };

  MassPerTime _toMassUnit(MassUnit toMass) => MassPerTime(
        _value * massUnit.convertFactor(to: toMass),
        toMass,
        perTimeUnit,
      );
  MassPerTime _toTimeUnit(TimeUnit perTimeUnit) => MassPerTime(
        _value /
            this.perTimeUnit.convertFactor(
                  toTime: perTimeUnit,
                ),
        massUnit,
        perTimeUnit,
      );

  MassPerTime as([MassUnit? massUnit, TimeUnit? perTimeUnit]) =>
      _toMassUnit(massUnit ?? this.massUnit)
          ._toTimeUnit(perTimeUnit ?? this.perTimeUnit);

  num asNumber([MassUnit? massUnit, TimeUnit? perTimeUnit]) =>
      as(massUnit, perTimeUnit)._value;

  VolumePerTime operator /(MassPerVolume volume) => VolumePerTime(
        asNumber(volume.massUnit) /
            volume.asNumber(volume.massUnit, volume.volumeUnit),
        volume.volumeUnit,
        perTimeUnit,
      );

  MassPerMassTime divide(Mass patientWeight) => MassPerMassTime(
        asNumber() / patientWeight.asNumber(),
        massUnit,
        patientWeight.unit,
        perTimeUnit,
      );
  Mass operator *(Time time) => Mass(
        asNumber(massUnit, TimeUnit.hour) * time.asNumber(TimeUnit.hour),
        massUnit,
      );
}
