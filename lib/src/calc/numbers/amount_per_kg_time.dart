import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_calc/src/calc/Calc.dart';
import 'package:unit_calc/src/calc/enum/concentration_unit.dart';
import 'package:unit_calc/src/calc/enum/time_unit.dart';
import 'package:unit_calc/src/calc/numbers/amount_per_time.dart';
import 'package:unit_calc/src/calc/numbers/number.dart';
import 'package:unit_calc/src/calc/utils.dart';

import 'mass.dart';

@immutable
class AmountPerKGTime with EquatableMixin implements Number {
  final double value;
  final ConcentrationUnit unit;
  final TimeUnit timeUnit;
  const AmountPerKGTime(this.value, this.unit, this.timeUnit)
      : assert(value > 0);

  String get _unit => "${unit.name}/kg/${timeUnit.name}";

  @override
  String toDisplayString([DigitOverride? override, NumberFormat? format]) =>
      "${NumberUtils.toDecimalString(value, override, format)} $_unit";

  @override
  String toString() => toDisplayString();

  //TODO: test this function
  AmountPerTime operator *(Mass mass) =>
      AmountPerTime(mass.value * value, unit, timeUnit);

  //TODO: test this function
  AmountPerKGTime convertToTime(ConcentrationUnit toUnit, TimeUnit toTime) =>
      AmountPerKGTime(
          value *
              Calc.convertFactor(
                  from: unit, to: toUnit, fromTime: timeUnit, toTime: toTime),
          toUnit,
          toTime);

  @override
  List<Object?> get props => [
        value,
        unit,
        timeUnit,
      ];
  @override
  bool? get stringify => false;
}
