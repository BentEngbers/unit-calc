import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/mass_per_kg_time.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';

import 'package:unit_calc/src/calc/utils.dart';
import 'package:unit_calc/unit_calc.dart';

import '../Calc.dart';

@immutable
final class MassPerTime with EquatableMixin implements Number {
  final double value;
  final TimeUnit _timeUnit;
  final MassUnit unit;
  TimeUnit get timeUnit => _timeUnit;
  const MassPerTime(this.value, this.unit, this._timeUnit) : assert(value >= 0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassPerTime &&
          runtimeType == other.runtimeType &&
          Calc.doubleEquals(
              value *
                  Calc.convertFactor(
                      from: unit,
                      to: other.unit,
                      fromTime: timeUnit,
                      toTime: other.timeUnit),
              other.value);

  @override
  int get hashCode => _timeUnit.hashCode ^ super.hashCode;

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(value, override, format)} ${unit.name}/${timeUnit.name}";
  @override
  String toString() => toDisplayString();

  VolumePerTime operator /(MassPerVolume volume) {
    final double convertedValue =
        value * Calc.convertFactorOnlyUnit(from: unit, to: volume.unit);
    return VolumePerTime(convertedValue / volume.value, _timeUnit);
  }

  //TODO: test this function div
  AmountPerKGTime divide(Mass patientWeight) =>
      AmountPerKGTime(value / patientWeight.value, unit, timeUnit);

  @override
  List<Object?> get props => [
        value,
        unit,
        timeUnit,
      ];
  @override
  bool? get stringify => false;
}
